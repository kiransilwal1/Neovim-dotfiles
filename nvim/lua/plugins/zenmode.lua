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
          font = "+4", -- font size increment
        },
        options = {
          laststatus = 0,
        },
        twilight = {
          enabled = false,
        },
      },
      on_open = function()
        require("package-info").hide()
      end,
    },
  },
}
