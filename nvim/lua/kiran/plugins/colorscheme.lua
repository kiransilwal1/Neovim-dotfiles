return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
      transparent_background = true,
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      integrations = {
        treesitter = true,
        cmp = true,
        nvimtree = true,
        telescope = true,
      },
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
