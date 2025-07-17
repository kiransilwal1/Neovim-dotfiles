return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("flutter-tools").setup({
        -- Your existing flutter-tools configuration
      })

      -- Add keymaps after setup
      local opts = { noremap = true, silent = true }

      -- Format, save, and hot reload
      vim.keymap.set("n", "ss", function()
        pcall(vim.lsp.buf.format, { async = false, timeout_ms = 2000 })
        vim.cmd("noautocmd w")
        require("flutter-tools.commands").reload()
        vim.notify("Formatted, saved, and hot reloaded", vim.log.levels.INFO)
      end, opts)

      -- Format, save, and hot restart
      vim.keymap.set("n", "sr", function()
        pcall(vim.lsp.buf.format, { async = false, timeout_ms = 2000 })
        vim.cmd("noautocmd w")
        require("flutter-tools.commands").restart()
        vim.notify("Formatted, saved, and hot restarted", vim.log.levels.INFO)
      end, opts)

      -- Additional Flutter keymaps
      vim.keymap.set("n", "<leader>fr", function()
        require("flutter-tools.commands").reload()
      end, { desc = "Flutter Hot Reload" })

      vim.keymap.set("n", "<leader>fR", function()
        require("flutter-tools.commands").restart()
      end, { desc = "Flutter Hot Restart" })

      vim.keymap.set("n", "<leader>fq", function()
        require("flutter-tools.commands").quit()
      end, { desc = "Flutter Quit" })

      vim.keymap.set("n", "<leader>fd", function()
        require("flutter-tools.commands").visual_debug()
      end, { desc = "Flutter Visual Debug" })
    end,
  },
}
