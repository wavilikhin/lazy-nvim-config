-- TypeScript LSP Configuration
--
-- Using vtsls (LazyVim default) for full feature support including:
-- - Path aliases (@/... mappings)
-- - Import suggestions
-- - Full diagnostics
--
-- tsgo (TypeScript 7 native) is faster but LSP is still in preview
-- and doesn't fully support path aliases yet.
-- See: https://github.com/microsoft/typescript-go/issues/1708
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Explicitly disable tsgo to prevent it from auto-starting
        -- (Neovim 0.11+ can auto-discover LSP configs)
        tsgo = { enabled = false },
        -- vtsls is enabled by default in LazyVim
      },
    },
  },
}
