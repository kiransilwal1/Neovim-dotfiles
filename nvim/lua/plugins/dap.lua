return {
  -- Add nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.set_log_level("DEBUG")

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
            url = "https://localhost:3000",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            webRoot = vim.fn.getcwd(),
            runtimeExecutable = "node",
            sourceMaps = true,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            url = "https://localhost:3000",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            webRoot = vim.fn.getcwd(),
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
    opts = {
      virt_text_win_col = 80,
    },
  },
}
