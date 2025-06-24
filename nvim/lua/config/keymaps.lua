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

function compile_and_run_c_file()
  local filepath = vim.fn.expand("%")
  local dirpath = vim.fn.fnamemodify(filepath, ":h")
  local filename = vim.fn.fnamemodify(filepath, ":t:r")
  local output_executable = dirpath .. "/" .. filename

  -- Compile the C file
  local compile_command = "gcc -o " .. output_executable .. " " .. filepath .. " 2>&1"
  local compile_output = vim.fn.system(compile_command)

  -- Check for compilation errors
  if vim.v.shell_error ~= 0 then
    vim.notify("Compilation failed:\n" .. compile_output, vim.log.levels.ERROR)
    return
  end

  -- Run the compiled executable in a new terminal window
  local run_command = "alacritty -e " .. output_executable -- Change `alacritty` to your terminal
  vim.fn.jobstart(run_command, { detach = true })
end

vim.api.nvim_set_keymap("n", "<leader>cx", ":lua compile_and_run_c_file()<CR>", { noremap = true, silent = true })

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
--keymap.set("n", "<M-,>", "<c-w>5<")
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

-- Obsidian related keymaps
--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
-- >>> ou # sync local with Notion
--
-- navigate to vault
vim.keymap.set(
  "n",
  "<leader>oo",
  ":cd /Users/kiransilwal/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/KiranSecondBrain<cr>"
)
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--
-- search for files in full vault
vim.keymap.set(
  "n",
  "<leader>os",
  ':Telescope find_files search_dirs={"/Users/kiransilwal/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/KiranSecondBrain/notes"}<cr>'
)
vim.keymap.set(
  "n",
  "<leader>oz",
  ':Telescope live_grep search_dirs={"/Users/kiransilwal/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/KiranSecondBrain/notes"}<cr>'
)
--
-- search for files in notes (ignore zettelkasten)
-- vim.keymap.set("n", "<leader>ois", ":Telescope find_files search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
-- vim.keymap.set("n", "<leader>oiz", ":Telescope live_grep search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
--
-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set(
  "n",
  "<leader>ok",
  ":!mv '%:p' /Users/kiransilwal/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/KiranSecondBrain/zettelkasten<cr>:bd<cr>"
)
-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
