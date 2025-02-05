return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")

    -- Ensure opts.sources exists before inserting values
    opts.sources = opts.sources or {}

    table.insert(opts.sources, nls.builtins.formatting.black)
  end,
}
