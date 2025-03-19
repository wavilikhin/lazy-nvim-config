return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
    },
    eslint = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      settings = {
        workingDirectory = { mode = "auto" },
        format = true,
        validate = "on",
        rulesCustomizations = {},
        run = "onSave",
        problems = {
          shortenToSingleLine = false,
        },
        codeAction = {
          showDocumentation = {
            enable = true,
          },
        },
        codeActionOnSave = {
          enable = true,
          mode = "all",
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
    },
  },
}