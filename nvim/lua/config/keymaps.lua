-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: httpskeymap.://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local Util = require("lazyvim.util")

keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "ff", ":ZenMode<Return>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })

-- vim rest console
keymap.set("n", "<Space>xR", ":call VrcQuery()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dl", function()
  require("osv").launch({ port = 8086 })
end, { noremap = true })
-- Jump to next diagnostic
keymap.set("n", "ge", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic" })

-- Borderless terminal
vim.keymap.set("n", "<C-/>", function()
  Util.terminal(nil, { border = "none" })
end, { desc = "Term with border" })

-- Borderless lazygit
vim.keymap.set("n", "<leader>gg", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { desc = "Lazygit (root dir)" })

-- keymap.del({ "n", "i", "v" }, "<A-j>")
-- keymap.del({ "n", "i", "v" }, "<A-k>")
-- keymap.del("n", "<C-Left>")
-- keymap.del("n", "<C-Down>")
-- keymap.del("n", "<C-Up>")
-- keymap.del("n", "<C-Right>")

keymap.set("n", "<M-h>", '<Cmd>lua require("tmux").resize_left()<CR>', { silent = true })
keymap.set("n", "<M-j>", '<Cmd>lua require("tmux").resize_bottom()<CR>', { silent = true })
keymap.set("n", "<M-k>", '<Cmd>lua require("tmux").resize_top()<CR>', { silent = true })
keymap.set("n", "<M-l>", '<Cmd>lua require("tmux").resize_right()<CR>', { silent = true })

keymap.set("n", "<leader>xr", "<cmd>.lua<CR>", { desc = "Execute the current line" })
keymap.set("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Execute the current file" })
keymap.set("n", "<leader>1", "<cmd>Inspect<CR>", { desc = "Execute the current file" })

local set_keymap = vim.api.nvim_set_keymap

-- These mappings control the size of splits (height/width)
-- keymap.set("n", "<M-,>", "<c-w>5<")
-- keymap.set("n", "<M-.>", "<c-w>5>")
-- keymap.set("n", "<M-t>", "<C-W>+")
-- keymap.set("n", "<M-s>", "<C-W>-")

-- Split windows
keymap.set("n", "sh", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)
keymap.set("n", "ss", ":w<Return>", opts)
keymap.set("n", "ssq", ":wq<Return>", opts)
keymap.set("n", "qa", ":qa<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- package-info keymaps
set_keymap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
set_keymap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
set_keymap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
set_keymap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
set_keymap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)
