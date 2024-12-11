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
--
-- vim.fn.sign_define("DapBreakpoint", {})
-- vim.fn.sign_define("DapStopped", {})
--
-- -- Define custom signs for DAP
-- vim.fn.sign_define(
--   "DapBreakpoint",
--   { text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpointLine", numhl = "DapBreakpointLine" }
-- )
-- vim.fn.sign_define(
--   "DapStopped",
--   { text = "➡️", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
-- )
--
-- -- Highlight groups
-- vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75", bg = "NONE", bold = true })
-- vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#ffbd5e" }) -- Line highlight for breakpoints
-- vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "NONE", bold = true })
-- vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#ffbd5e" }) -- Line highlight for stopped execution
--
-- vim.api.nvim_set_hl(0, "@keyword.return.tsx", { bold = true, italic = true, fg = "#ffbd5e" })

--
-- vim.api.nvim_set_hl(0, "DapBreakpointSymbol", { fg = colors.red, bg = colors.bg1 })
--
-- vim.api.nvim_set_hl(0, "DapStoppedSymbol", { fg = colors.green, bg = colors.bg1 })
--
-- vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#ffbd5e" })
--
-- vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { fg = colors.gray })
--
-- vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = colors.aqua })
--
-- vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = colors.yellow })
--
-- vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUICurrentFrameName", { fg = colors.purple })
--
-- vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = colors.purple })
--
-- vim.api.nvim_set_hl(0, "DapUIEndofBuffer", { fg = colors.bg2 })
--
-- vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = colors.aqua })
--
-- vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = colors.yellow })
--
-- vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = colors.red })
--
-- vim.api.nvim_set_hl(0, "DapUIPlayPause", { fg = colors.green })
--
-- vim.api.nvim_set_hl(0, "DapUIRestart", { fg = colors.green })
--
-- vim.api.nvim_set_hl(0, "DapUIScope", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUISource", { fg = colors.fg1 })
--
-- vim.api.nvim_set_hl(0, "DapUIStepBack", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIStepInto", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIStepOut", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIStepOver", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIStop", { fg = colors.red })
--
-- vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIThread", { fg = colors.blue })
--
-- vim.api.nvim_set_hl(0, "DapUIType", { fg = colors.orange })
--
-- vim.api.nvim_set_hl(0, "DapUIUnavailable", { fg = colors.gray })
--
-- vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = colors.gray })
--
-- vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = colors.red })
--
-- vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = colors.yellow })
--
-- vim.api.nvim_set_hl(0, "DapUIWinSelect", { fg = colors.yellow })
