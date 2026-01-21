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
      float = {
        max_width = 70,
        max_height = 20,
      },
    },
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  },
}
