-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- DEFALUTS
--
local keymap = vim.keymap.set

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
keymap({ "n", "v" }, "<leader>d", [["_d]])

keymap("n", "<leader>f", vim.lsp.buf.format)

keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")

keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all content" })

-- If you want to add another shortcut, for example Command+S for macOS:
keymap({ "i", "v", "n" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--
-- PLUGINS
--
-- oil
--

keymap("n", "-", "<CMD>Oil --float <CR>", { desc = "Open parent directory" })
