-- Notification Logger
-- Logs all Neovim notifications (errors, warnings, info) to a file for later analysis

local M = {}

-- Log file path in the nvim config directory
M.log_file = vim.fn.stdpath("config") .. "/notifications.log"

-- Maximum log file size in bytes (5MB default)
M.max_file_size = 5 * 1024 * 1024

-- Log levels mapping
local level_names = {
  [vim.log.levels.TRACE] = "TRACE",
  [vim.log.levels.DEBUG] = "DEBUG",
  [vim.log.levels.INFO] = "INFO",
  [vim.log.levels.WARN] = "WARN",
  [vim.log.levels.ERROR] = "ERROR",
  [vim.log.levels.OFF] = "OFF",
}

-- Format timestamp
local function get_timestamp()
  return os.date("%Y-%m-%d %H:%M:%S")
end

-- Get level name from level number
local function get_level_name(level)
  return level_names[level] or "UNKNOWN"
end

-- Rotate log file if it exceeds max size
local function maybe_rotate_log()
  local stat = vim.loop.fs_stat(M.log_file)
  if stat and stat.size > M.max_file_size then
    local backup = M.log_file .. ".old"
    os.remove(backup)
    os.rename(M.log_file, backup)
  end
end

-- Write a log entry to file
function M.log(msg, level, opts)
  opts = opts or {}

  maybe_rotate_log()

  local file = io.open(M.log_file, "a")
  if not file then
    return
  end

  local timestamp = get_timestamp()
  local level_name = get_level_name(level or vim.log.levels.INFO)
  local title = opts.title or ""

  -- Format: [TIMESTAMP] [LEVEL] [TITLE] MESSAGE
  local log_entry
  if title ~= "" then
    log_entry = string.format("[%s] [%s] [%s] %s\n", timestamp, level_name, title, msg)
  else
    log_entry = string.format("[%s] [%s] %s\n", timestamp, level_name, msg)
  end

  file:write(log_entry)
  file:close()
end

-- Setup function to wrap vim.notify
function M.setup()
  -- Store original vim.notify
  local original_notify = vim.notify

  -- Replace vim.notify with logging version
  vim.notify = function(msg, level, opts)
    M.log(msg, level, opts)
    return original_notify(msg, level, opts)
  end

  -- Log startup
  M.log("Neovim session started", vim.log.levels.INFO, { title = "Session" })

  -- Log on exit
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      M.log("Neovim session ended", vim.log.levels.INFO, { title = "Session" })
    end,
  })
end

-- Command to open the log file
function M.open_log()
  vim.cmd("edit " .. M.log_file)
end

-- Command to clear the log file
function M.clear_log()
  local file = io.open(M.log_file, "w")
  if file then
    file:close()
    vim.notify("Notification log cleared", vim.log.levels.INFO)
  end
end

-- Command to tail the log (show last N entries)
function M.tail_log(n)
  n = n or 50
  local file = io.open(M.log_file, "r")
  if not file then
    vim.notify("No log file found", vim.log.levels.WARN)
    return
  end

  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()

  -- Get last n lines
  local start = math.max(1, #lines - n + 1)
  local result = {}
  for i = start, #lines do
    table.insert(result, lines[i])
  end

  -- Display in a floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "log")

  local width = math.min(120, vim.o.columns - 4)
  local height = math.min(#result, vim.o.lines - 4)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
    title = " Notification Log (last " .. n .. ") ",
    title_pos = "center",
  })

  -- Close on q or Escape
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end

-- Register user commands
vim.api.nvim_create_user_command("NotifyLogOpen", function()
  M.open_log()
end, { desc = "Open notification log file" })

vim.api.nvim_create_user_command("NotifyLogClear", function()
  M.clear_log()
end, { desc = "Clear notification log file" })

vim.api.nvim_create_user_command("NotifyLogTail", function(opts)
  M.tail_log(tonumber(opts.args) or 50)
end, { nargs = "?", desc = "Show last N log entries (default 50)" })

return M
