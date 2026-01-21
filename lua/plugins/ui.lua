return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.cmdline = {
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "" },
          search_down = { kind = "search", pattern = "^/", icon = "/", lang = "" },
          search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?", lang = "" },
        },
      }
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      terminal = {},
    },
    keys = {},
  },
  {
    "folke/zen-mode.nvim",
    lazy = false, -- Load immediately
    config = function()
      local zen_mode = require("zen-mode")

      -- Global variable to store Zen Mode state
      _G.zen_mode_enabled = false

      zen_mode.setup({
        -- your existing zen-mode configuration
        on_open = function()
          _G.zen_mode_enabled = true
        end,
        on_close = function()
          _G.zen_mode_enabled = false
        end,
      })

      -- Function to toggle Zen Mode and persist the state
      _G.toggle_zen_mode = function()
        if _G.zen_mode_enabled then
          zen_mode.close()
          _G.zen_mode_enabled = false
        else
          zen_mode.open()
          _G.zen_mode_enabled = true
        end
      end

      -- Autocommand to open Zen Mode when a buffer is created
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          if _G.zen_mode_enabled then
            -- Check if oil is active, if not activate zen mode
            if not vim.b.oil_active then
              zen_mode.open()
            end
          end
        end,
      })

      -- Keymap to toggle Zen Mode
      vim.keymap.set("n", "<leader>z", _G.toggle_zen_mode, { desc = "Toggle Zen Mode" })
    end,
  },
}
