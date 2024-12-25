return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      skip_confirm_for_simple_edits = true,
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
}