return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({
      flutter_path = "/Users/kiransilwal/Development/flutter/bin/flutter",
      dart_path = "/Users/kiransilwal/Development/flutter/bin/dart",
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit",
      },
    })
  end,
}
