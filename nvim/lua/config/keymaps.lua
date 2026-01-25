-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Auto-correct nearest spelling error to the left of cursor
-- [s jumps to previous misspelled word, 1z= applies first suggestion, `]a returns to original position
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a", { desc = "Fix nearest spelling error" })
vim.keymap.set("n", "<C-l>", "[s1z=", { desc = "Fix nearest spelling error" })
