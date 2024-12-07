-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.conceallevel = 0
opt.cmdheight = 0
vim.opt.foldenable = false

vim.g.root_spec = { "cwd" }
vim.g.omni_sql_no_default_maps = 1
vim.g.python3_host_prog = "/usr/bin/python3"
vim.opt.termguicolors = true

-- Define the custom highlight group
-- vim.api.nvim_set_hl(0, "ReturnKeyword", { bold = true, italic = true, fg = "#ffbd5e" })
vim.api.nvim_set_hl(0, "@keyword.return.", { bold = true, italic = true, fg = "#61afef" })

-- Define your custom highlight groups
vim.api.nvim_set_hl(0, "FunctionReturn", { fg = "#61afef", bold = true }) -- Blue for return-related
vim.api.nvim_set_hl(0, "TypeDefinition", { fg = "#e5c07b", bold = true }) -- Yellow for types

-- Link Tree-sitter groups to your custom highlight groups
vim.api.nvim_set_hl(0, "@function", { link = "FunctionReturn" }) -- Functions
vim.api.nvim_set_hl(0, "@keyword.return", { link = "FunctionReturn" }) -- Return keywords
vim.api.nvim_set_hl(0, "@type", { link = "TypeDefinition" }) -- Classes/Types
vim.api.nvim_set_hl(0, "@type.definition", { link = "TypeDefinition" }) -- Type definitions

-- vim.api.nvim_set_hl(0, "@keyword.return.tsx", { bold = true, italic = true, fg = "#ffbd5e" })

-- TODO : check what is wrong with the escape key. It is binding to something unexpected. Printing all the words to next line. Is it a macro?
-- TODO:It is because of formating
