return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.9,
      },
      plugins = {
        kitty = {
          enabled = true,
          font = "+8", -- font size increment
        },
        options = {
          laststatus = 0,
        },
        twilight = {
          enabled = false,
        },
      },
    },
  },
}
