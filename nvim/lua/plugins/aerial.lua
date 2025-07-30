return {
  "stevearc/aerial.nvim",
  opts = {
    close_automatic_events = {
      "unfocus",
      "switch_buffer",
    },
    guides = {
      nested_top = " │ ",
      mid_item = " ├─",
      last_item = " └─",
      whitespace = "   ",
    },
    layout = {
      placement = "edge",
      close_on_select = false,
      max_width = 30,
      min_width = 30,
    },
    ignore = {
      buftypes = {},
    },
    icons = tools.ui.kind_icons,
    show_guides = true,
    open_automatic = function()
      local aerial = require("aerial")
      return vim.api.nvim_win_get_width(0) > 80 and not aerial.was_closed()
    end,
  },
  config = function(_, opts)
    require("aerial").setup(opts)

    -- Keybinding
    vim.keymap.set("n", "<leader>vs", "<cmd>AerialToggle<cr>", {
      silent = true,
      desc = "Toggle Aerial",
    })

    -- Highlight overrides for transparency
    vim.api.nvim_set_hl(0, "AerialNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
--
--
-- return {
--   "stevearc/aerial.nvim",
--   opts = {
--     close_automatic_events = {
--       "unfocus",
--       "switch_buffer",
--     },
--     guides = {
--       nested_top = " │ ",
--       mid_item = " ├─",
--       last_item = " └─",
--       whitespace = "   ",
--     },
--     layout = {
--       placement = "edge",
--       close_on_select = false,
--       max_width = 30,
--       min_width = 30,
--     },
--     ignore = {
--       buftypes = {},
--     },
--     icons = tools.ui.kind_icons,
--     show_guides = true,
--     open_automatic = function()
--       local aerial = require("aerial")
--       return vim.api.nvim_win_get_width(0) > 80 and not aerial.was_closed()
--     end,
--   },
--   config = function(_, opts)
--     require("aerial").setup(opts)
--
--     vim.keymap.set("n", "<leader>vs", "<cmd>AerialToggle<cr>", {
--       silent = true,
--       desc = "Toggle Aerial",
--     })
--   end,
-- }
