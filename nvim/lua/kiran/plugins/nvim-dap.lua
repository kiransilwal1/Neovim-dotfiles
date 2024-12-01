return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.set_log_level("TRACE")

    -- DAP UI Setup
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybindings
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue Debugging" })
    vim.keymap.set("n", "<leader>dn", function()
      dap.run(dap.configurations.javascript[1])
    end, { desc = "Debug Backend" })
    vim.keymap.set("n", "<leader>df", function()
      dap.run(dap.configurations.javascriptreact[1])
    end, { desc = "Debug Frontend" })

    -- Adapter for Backend (Node.js)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { "/Users/kiransilwal/.config/nvim/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    -- Adapter for Frontend (Chrome)
    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = 9222,
      executable = {
        command = "node",
        args = { "/Users/kiransilwal/.config/nvim/js-debug/src/dapDebugServer.js", "9222" },
      },
    }

    -- Debug Configurations
    dap.configurations.javascript = {
      {
        name = "Next.js Backend",
        type = "pwa-node",
        request = "launch",
        program = "${workspaceFolder}/node_modules/.bin/next",
        args = { "dev" },
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "--inspect" },
        port = 9229,
        sourceMaps = true,
        skipFiles = { "<node_internals>/**" },
      },
    }

    dap.configurations.javascriptreact = {
      {
        name = "Next.js Frontend (Chrome)",
        type = "pwa-chrome",
        request = "attach",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        port = 9222,
        skipFiles = { "<node_internals>/**" },
      },
    }

    dap.configurations.typescriptreact = dap.configurations.javascriptreact
  end,
}
