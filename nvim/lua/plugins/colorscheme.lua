return {
  "mcauley-penney/techbase.nvim",
  branch = "transparency",
  lazy = false,
  opts = {
    transparent = true,
    italic_comments = true,
    borderless_telescope = false,
  },
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("techbase")

    -- Force transparent background after setting colorscheme
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "AerialNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
