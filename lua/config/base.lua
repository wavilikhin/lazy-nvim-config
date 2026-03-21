vim.opt.ai = true
vim.opt.si = true
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Configure diagnostic floats to match hover popups
vim.diagnostic.config({
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
    suffix = "",
    max_width = 88,
    scope = "line",
  },
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "●",
    },
  },
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { link = "DiagnosticHint" })
