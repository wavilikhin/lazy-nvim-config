return {
  {
    "ThePrimeagen/harpoon",
    keys = function()
      local harpoon = require("harpoon")
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<C-e>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },

        {
          "<C-h>",
          function()
            harpoon:list():select(1)
          end,
        },
        {
          "<C-t>",
          function()
            harpoon:list():select(2)
          end,
        },
        {
          "<C-n>",
          function()
            harpoon:list():select(3)
          end,
        },
        {
          "<C-s>",
          function()
            harpoon:list():select(4)
          end,
        },
      }
      return keys
    end,
  },
}