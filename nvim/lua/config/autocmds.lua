-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- NOTE: Autocommands

local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

autocmd("VimEnter", {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      vim.cmd("Telescope find_files")
      -- require("nvim-tree.api").tree.open()
    end
  end,
  group = general,
  desc = "Open Telescope when it's a Directory",
})

-- Enable Line Number in Telescope Preview
-- autocmd("User", {
--   pattern = "TelescopePreviewerLoaded",
--   :w
--   callback = function()
--     vim.opt_local.number = true
--   end,
--   group = general,
--   desc = "Enable Line Number in Telescope Preview",
-- })

-- Hide folds and Disable statuscolumn in these filetypes
autocmd("FileType", {
  pattern = { "sagaoutline", "nvcheatsheet" },
  callback = function()
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.stc = "" -- not really important
  end,
  group = general,
  desc = "Disable Fold & StatusColumn",
})

-- Remove this if there's an issue
autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    -- In wsl 2, just install xclip
    -- Ubuntu
    -- sudo apt install xclip
    -- Arch linux
    -- sudo pacman -S xclip
    vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
  end,
  group = general,
  desc = "Lazy load clipboard",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd("startinsert!")
  end,
  group = general,
  desc = "Terminal Options",
})

autocmd("BufReadPost", {
  callback = function()
    if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  group = general,
  desc = "Go To The Last Cursor Position",
})

autocmd("TextYankPost", {
  callback = function()
    if vim.version().minor >= 11 then
      require("vim.hl").on_yank({ higroup = "Visual", timeout = 200 })
    else
      require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
    end
  end,
  group = general,
  desc = "Highlight when yanking",
})

autocmd({ "BufEnter", "BufNewFile" }, {
  callback = function()
    vim.o.showtabline = 0
  end,
  group = general,
  desc = "Disable Tabline",
})

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("FileType", {
  pattern = { "c", "cpp", "py", "java", "cs" },
  callback = function()
    vim.bo.shiftwidth = 4
  end,
  group = general,
  desc = "Set shiftwidth to 4 in these filetypes",
})

-- local ns_id = vim.api.nvim_create_namespace("autosave")
--
-- vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "BufWinLeave", "InsertLeave" }, {
--   callback = function()
--     -- Only save if the buffer is modified and not a help file
--     if vim.bo.filetype ~= "" and vim.bo.buftype == "" and vim.bo.modified and vim.bo.filetype ~= "help" then
--       -- Get the current cursor position (1-based index)
--       local cursor_pos = vim.api.nvim_win_get_cursor(0)
--       local row, col = cursor_pos[1] - 1, cursor_pos[2] -- Convert to 0-based index
--
--       -- Create a namespace for the virtual text
--       local ns_id = vim.api.nvim_create_namespace("autosave")
--
--       -- Set virtual text near the cursor position
--       vim.api.nvim_buf_set_extmark(0, ns_id, row, col, {
--         virt_text = { { "💾", "Comment" } },
--         virt_text_pos = "overlay", -- Overlay the text on top of the current line
--         hl_mode = "combine", -- Combine with the background color
--         -- Optional settings to ensure the text is visible even at the screen's edge
--         virt_text_win_col = col + 1, -- Move text slightly to the right of the cursor (can adjust as needed)
--       })
--
--       -- Trigger LSP formatting before saving
--       -- vim.lsp.buf.format({ async = false })
--
--       -- Perform the save
--       vim.cmd("silent! nested w")
--
--       -- Clear the virtual text after a short delay (e.g., 300ms)
--       vim.defer_fn(function()
--         vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
--       end, 300) -- 300ms delay (adjust as needed)
--     end
--   end,
--   nested = true,
--   desc = "Auto Save with LSP Formatting and Loading Icon",
-- })

autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = general,
  desc = "Update file when there are changes",
})

autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end,
  group = general,
  desc = "Equalize Splits",
})

autocmd("ModeChanged", {
  callback = function()
    if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
      vim.opt.hlsearch = true
    else
      vim.opt.hlsearch = false
    end
  end,
  group = general,
  desc = "Highlighting matched words when searching",
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "log" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = general,
  desc = "Enable Wrap in these filetypes",
})

local overseer = augroup("Overseer", { clear = true })

autocmd("FileType", {
  pattern = "OverseerList",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd("startinsert!")
  end,
  group = overseer,
  desc = "Enter Normal Mode In OverseerList",
})
