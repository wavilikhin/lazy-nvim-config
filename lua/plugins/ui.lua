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

      opts.popupmenu = opts.popupmenu or {}
      opts.popupmenu.backend = "nui"

      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        progress = { enabled = false },
        hover = {
          enabled = true,
          silent = true,
        },
        signature = {
          enabled = true,
          auto_open = { enabled = true },
        },
        documentation = {
          view = "hover",
          opts = {
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = {
              wrap = true,
              linebreak = true,
              concealcursor = "n",
              conceallevel = 3,
              winblend = 0,
            },
          },
        },
      })

      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#24201f" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7c6f64", bg = "#24201f" })
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
    lazy = false,
    config = function()
      local zen_mode = require("zen-mode")

      local zen_open = false

      zen_mode.setup({
        on_open = function()
          zen_open = true
        end,
        on_close = function()
          zen_open = false
        end,
        window = {
          backdrop = 0.95,
          width = 120,
          options = {},
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
        },
      })

      -- Toggle Zen Mode
      local function toggle_zen_mode()
        if zen_open then
          zen_mode.close()
        else
          zen_mode.open()
        end
      end

      vim.keymap.set("n", "<leader>z", toggle_zen_mode, { desc = "Toggle Zen Mode" })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    name = "github-theme",
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },
}
