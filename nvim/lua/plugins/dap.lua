return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "[",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "]",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
  },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "jbyuki/one-small-step-for-vimkind" },
    opts = {
      layouts = {
        {
          elements = {
            -- { id = "console", size = 0.5 },
            -- { id = "repl", size = 0.5 },
          },
          position = "left",
          size = 50,
        },
        {
          elements = {
            { id = "scopes", size = 0.50 },
            { id = "breakpoints", size = 0.20 },
            -- { id = "stacks", size = 0.15 },
            -- { id = "watches", size = 0.15 },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
    config = function(_, opts)
      require("dapui").setup(opts)

      local listener = require("dap").listeners
      listener.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      listener.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      listener.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end
    end,
  },

  config = function()
    local dap = require("dap")
    dap.set_log_level("DEBUG")

    -- Define custom signs
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpointLine", numhl = "DapBreakpointLine" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "➡️", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
    )

    -- Clear and redefine signs on VimEnter to prevent conflicts
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.fn.sign_define("DapBreakpoint", { text = "" })
        vim.fn.sign_define("DapStopped", { text = "" })
        vim.fn.sign_define(
          "DapBreakpoint",
          { text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpointLine", numhl = "DapBreakpointLine" }
        )
        vim.fn.sign_define(
          "DapStopped",
          { text = "➡️", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
        )
      end,
    })

    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "DapBreakpointLine", { bg = "#424242" }) -- Line highlight for breakpoints
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#424242" }) -- Line highlight for stopped execution

    -- Python dap configurations
    dap.adapters.python = {
      type = "server",
      host = "127.0.0.1",
      port = 5678, -- must match the port used in debugpy
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "attach",
        name = "Attach to FastAPI (debugpy)",
        connect = {
          port = 5678,
          host = "127.0.0.1",
        },
        mode = "remote",
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(), -- adjust if code is in a different folder
            remoteRoot = ".",
          },
        },
      },
    }

    dap.adapters.python = {
      type = "executable",
      command = vim.fn.exepath("python"), -- Uses the Python from the current terminal session
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- Runs the current file
        console = "integratedTerminal", -- Runs in the same terminal as Neovim
      },
    }

    -- Adapter configurations
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
    dap.adapters["chrome"] = {
      type = "executable",
      command = "node",
      args = { "/Users/kiransilwal/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
    }
    dap.adapters.dart = {
      type = "executable",
      command = "/Users/kiransilwal/Development/flutter/bin/dart",
      args = { "debug_adapter" },
      options = {
        detached = false,
      },
    }
    dap.adapters.flutter = {
      type = "executable",
      command = "/Users/kiransilwal/Development/flutter/bin/flutter",
      args = { "debug_adapter" },
      options = {
        detached = false,
      },
    }
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { "/Users/kiransilwal/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for xdebug",
        port = "9003",
        log = false,
        serverSourceRoot = "/srv/www/",
        localSourceRoot = "/home/www/VVV/www/",
      },
      {
        type = "php",
        request = "launch",
        name = "Individual debugging",
        port = "9003",
        -- pathMappings = {
        --   [vim.fn.getcwd()] = "/var/www/html/", -- map local to remote dynamically based on current directory
        -- },
        localSourceRoot = vim.fn.getcwd(),
      },
    }

    -- Configure JavaScript/TypeScript languages
    local js_based_languages = { "vue", "typescript", "javascriptreact", "typescriptreact", "javascript" }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "attach",
          port = 9230,
          skipFiles = {
            "<node_internals>/**",
            "node_modules/**",
            "${workspaceRoot}/node_modules/**/*.js",
            "${workspaceFolder}/node_modules/**/*.js",
            "<node_internals>/**/*.js",
          },
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node (Javascript)",
          port = 9229,
          restart = true,
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug MCP Server (ts-node)",
          runtimeExecutable = "ts-node",
          runtimeArgs = { "--inspect-brk" },
          args = { "${workspaceFolder}/src/index.ts" },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
          autoAttachChildProcesses = true, -- Important for handling child processes
          resolveSourceMapLocations = {
            "${workspaceFolder}/**/*.js",
            "${workspaceFolder}/**/*.ts",
            "!**/node_modules/**",
          },
        },

        {
          name = "Node Server",
          type = "pwa-node",
          request = "attach",
          port = 9229,
        },
        {
          name = "Next.js: debug client-side",
          type = "chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**/*.js" },
          sourceMaps = true,
          sourceMapPathOverrides = {
            ["webpack://_N_E/*"] = "${webRoot}/*",
            ["turbopack://_N_E/*"] = "${webRoot}/*",
          },
          {
            name = "Debug Full-Stack",
            type = "composite", -- Use composite to combine multiple configurations
            configurations = { "Debug Server-Side", "Debug Client-Side" },
          },
        },

        {
          name = "Vue: Debug Client-Side",
          type = "chrome",
          request = "launch",
          url = "http://localhost:5173", -- Update to match your local dev server URL
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          sourceMapPathOverrides = {
            ["webpack:///src/*"] = "${webRoot}/src/*",
            ["webpack:///.*"] = "${webRoot}/*",
          },
        },
        {
          name = "Vue: Attach to Chrome",
          type = "chrome",
          request = "attach",
          port = 9222, -- Default port for Chrome remote debugging
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          sourceMapPathOverrides = {
            ["webpack:///src/*"] = "${webRoot}/src/*",
            ["webpack:///.*"] = "${webRoot}/*",
          },
        },
      }
    end
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }

    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end

    -- Dart and Flutter configurations
    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch dart",
        dartSdkPath = "/Users/kiransilwal/Development/flutter/bin/dart",
        flutterSdkPath = "/Users/kiransilwal/Development/flutter/bin/flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
      },
      {
        name = "Launch Flutter App",
        type = "flutter",
        request = "launch",
        dartSdkPath = "/Users/kiransilwal/Development/flutter/bin/dart",
        flutterSdkPath = "/Users/kiransilwal/Development/flutter/bin/flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        args = function()
          local devices = vim.fn.systemlist("flutter devices")
          local device_list = {}

          for _, device in ipairs(devices) do
            local id = device:match("%S+%s(%S+)%s")
            if id then
              table.insert(device_list, id)
            end
          end

          if #device_list == 0 then
            vim.notify("No devices found. Please connect a device and try again.", vim.log.levels.ERROR)
            return {}
          end

          local chosen_device = vim.fn.inputlist(vim.tbl_map(function(device_id)
            return "Device: " .. device_id
          end, device_list))

          if chosen_device < 1 or chosen_device > #device_list then
            vim.notify("Invalid device selection.", vim.log.levels.ERROR)
            return {}
          end

          return { "-d", device_list[chosen_device] }
        end,
      },
    }
  end,
}
