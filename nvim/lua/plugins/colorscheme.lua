return {
  "mcauley-penney/techbase.nvim",
  branch = "main", -- or "dev", etc., if using a custom branch
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("techbase")
  end,
}
--
--
-- return {
--   "mcauley-penney/techbase.nvim",
--   branch = "transparency",
--   opts = {
--     transparent = true,
--     overrides = {},
--   },
--   config = function(_, opts)
--     require("techbase").setup(opts)
--     vim.cmd.colorscheme("techbase")
--   end,
--   priority = 1000,
-- }
