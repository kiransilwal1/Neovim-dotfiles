-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.conceallevel = 0
opt.cmdheight = 0

vim.g.root_spec = { "cwd" }
vim.g.omni_sql_no_default_maps = 1
vim.g.python3_host_prog = "/usr/bin/python3"

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.root_spec = { "cwd" }
vim.g.omni_sql_no_default_maps = 1
-- vim.g.python3_host_prog = "/usr/bin/python3"
vim.fn.setenv("DAP_LOG", "~/.cache/nvim/nvim-dap.log")

-- vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#A6E22E", bg = nil, bold = true }) --Neotree file
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#838ba7", bg = nil, bold = true }) --Neotree file
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#838ba7", bg = nil, bold = true }) --Neotree file
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#a6d189", bg = nil, bold = true }) --Neotree file
vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#838ba7", bg = nil, bold = true }) --Neotree file

vim.api.nvim_set_hl(0, "@keyword.return", {
  fg = "#f4b8e4", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@lsp.type.function", {
  fg = "#81c8be", -- keep default foreground color or set custom color if needed
  bold = true, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})

vim.api.nvim_set_hl(0, "@function.builtin", {
  fg = "#ca9ee6", -- keep default foreground color or set custom color if needed
  bold = true, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})

vim.api.nvim_set_hl(0, "@keyword.function", {
  fg = "#ca9ee6", -- keep default foreground color or set custom color if needed
  bold = true, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})

vim.api.nvim_set_hl(0, "@variable", {
  fg = "#8caaee", -- keep default foreground color or set custom color if needed
  bold = false, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})

vim.api.nvim_set_hl(0, "@keyword.coroutine.typescript", {
  fg = "#f4b8e4", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@lsp.type.interface.typescriptreact", {
  fg = "#e5c890", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@keyword.coroutine.tsx", {
  fg = "#f4b8e4", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@keyword.return.tsx", {
  fg = "#f4b8e4", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@keyword.return.ts", {
  fg = "#f4b8e4", -- Keep default foreground color or set custom color if needed
  bold = true, -- Apply bold style
  bg = nil, -- Keep default background color or set custom color if needed
  italic = true, -- Apply italic style
})

vim.api.nvim_set_hl(0, "@tag.builtin.tsx", {
  fg = "#f2b291", -- keep default foreground color or set custom color if needed
  bold = false, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})

vim.api.nvim_set_hl(0, "@tag.tsx", {
  fg = "#ef9f76", -- keep default foreground color or set custom color if needed
  bold = false, -- apply bold style
  bg = nil, -- keep default background color or set custom color if needed
  italic = false, -- apply italic style
})
