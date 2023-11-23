-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--  Tabs
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- navigate windows
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-w>", "<C-w>w") -- switch windows

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "x", '"_x')

-- Shift arrow like in gui
keymap.set("n", "<S-Up>", "v<Up>")
keymap.set("n", "<S-Down>", "v<Down>")
keymap.set("n", "<S-Left>", "v<Left>")
keymap.set("n", "<S-Right>", "v<Right>")
keymap.set("v", "<S-Up>", "<Up>")
keymap.set("v", "<S-Down>", "<Down>")
keymap.set("v", "<S-Left>", "<Left>")
keymap.set("v", "<S-Right>", "<Right>")
keymap.set("i", "<S-Up>", "<Esc>v<Up>")
keymap.set("i", "<S-Down>", "<Esc>v<Down>")
keymap.set("i", "<S-Left>", "<Esc>v<Left>")
keymap.set("i", "<S-Right>", "<Esc>v<Right>")

--- Misc
--
-- create an empty line below the current cursor position without entering insert mode
keymap.set("n", "_", ":put_<Return>")
-- use jj to exit insert mode
keymap.set({ "v", "i" }, "jj", "<ESC>")
-- open recent files window
keymap.set("n", "<F3>", ":browse oldfiles<Return>")

--- GUI
if vim.g.neovide then
  keymap.set({ "n", "i" }, "<C-v>", ":put<Return>", opts)
end
--- Plugins
--
-- Vimwiki
keymap.set("n", "<C-Space>", ":VimwikiToggleListItem<Return>")
-- open file explorer
keymap.set("n", "<F2>", "<Cmd>Neotree toggle<Return>")
-- open Dashboard
keymap.set("n", "<F4>", "<Cmd>:Dashboard<Return>")
