return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}

--
-- return {
--   "echasnovski/mini.surround",
--   opts = {
--     mappings = {
--       add = "as", -- Add surrounding in Normal and Visual modes
--       delete = "ds", -- Delete surrounding
--       find = "fs", -- Find surrounding (to the right)
--       find_left = "Fs", -- Find surrounding (to the left)
--       highlight = "hs", -- Highlight surrounding
--       replace = "rs", -- Replace surrounding
--       update_n_lines = "ns", -- Update `n_lines`
--     },
--   },
--   version = "*",
-- }
