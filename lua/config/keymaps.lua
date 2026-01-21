-- ============================================================================
-- KEYMAPS
-- Automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- ============================================================================

local map = vim.keymap.set

-- ============================================================================
-- NAVIGATION & SCROLLING
-- ============================================================================
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- ============================================================================
-- QUICKFIX & LOCATION LIST
-- ============================================================================
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location item" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location item" })

-- ============================================================================
-- LINE MANIPULATION
-- ============================================================================
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ============================================================================
-- CLIPBOARD & REGISTERS
-- ============================================================================
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- ============================================================================
-- SELECTION
-- ============================================================================
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================
map({ "i", "v", "n" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file (Cmd+S)" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer (LSP)" })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
map("n", "<C-S-h>", "<C-w><", { desc = "Decrease window width" })
map("n", "<C-S-l>", "<C-w>>", { desc = "Increase window width" })
map("n", "<C-S-k>", "<C-w>+", { desc = "Increase window height" })
map("n", "<C-S-j>", "<C-w>-", { desc = "Decrease window height" })

-- ============================================================================
-- NUMBER INCREMENT/DECREMENT
-- ============================================================================
map("n", "+", "<C-a>", { desc = "Increment number" })
-- NOTE: `-` is used by Oil file explorer, use <C-x> for decrement

-- ============================================================================
-- FILE EXPLORER (OIL)
-- ============================================================================
map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Oil file explorer" })
