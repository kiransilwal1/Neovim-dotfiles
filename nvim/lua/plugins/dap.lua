return {
  -- Add nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", config = true }, -- UI for nvim-dap
      { "theHamsta/nvim-dap-virtual-text", config = true }, -- Virtual text support
    },
    config = function()
      local dap = require("dap")

      -- Define `pwa-node` adapter
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            "/Users/kiransilwal/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Define `chrome` adapter
      dap.adapters["chrome"] = {
        type = "executable",
        command = "node",
        args = { "/Users/kiransilwal/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
      }

      -- Configure languages
      local js_based_languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          {
            name = "Next.js: debug server-side",
            type = "pwa-node",
            request = "attach",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            sourceMaps = true,
          },
          {
            name = "Next.js: debug client-side",
            type = "chrome",
            request = "launch",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
            sourceMapPathOverrides = {
              ["webpack://_N_E/*"] = "${webRoot}/*",
            },
          },
        }
      end
    end,
  },

  -- Optional: Additional plugins
  {
    "theHamsta/nvim-dap-virtual-text", -- Virtual text
    config = true,
  },
  {
    "rcarriga/nvim-dap-ui", -- UI for nvim-dap
    config = function()
      require("dapui").setup()
    end,
  },
}
