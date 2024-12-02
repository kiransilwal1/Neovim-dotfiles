return {
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = false, -- Disable tmux clipboard synchronization if unnecessary
        },
        navigation = {
          enable_default_keybindings = true, -- Enable default navigation keybindings
          persist_zoom = false, -- Prevent zoomed panes from unzooming
        },
        resize = {
          enable_default_keybindings = true, -- Enable default resizing keybindings
        },
        session = {
          cwd_sync = true, -- Ensure tmux sessions start with Neovim's cwd
        },
      })
    end,
  },
}
-- return {
--   {
--     "aserowy/tmux.nvim",
--     config = function()
--       return require("tmux").setup({
--         resize = {
--           enable_default_keybindings = false,
--         },
--       })
--     end,
--   },
-- }
