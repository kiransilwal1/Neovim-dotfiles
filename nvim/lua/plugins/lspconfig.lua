return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.tsserver = {
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      }
    end,
  },
}
