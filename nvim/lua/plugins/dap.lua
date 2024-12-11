return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        {
          elements = {
            { id = "console", size = 0.5 },
            { id = "repl", size = 0.5 },
          },
          position = "left",
          size = 50,
        },
        {
          elements = {
            { id = "scopes", size = 0.50 },
            { id = "breakpoints", size = 0.20 },
            { id = "stacks", size = 0.15 },
            { id = "watches", size = 0.15 },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
    config = function(_, opts) -- 👈 here, the _
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

    -- Define `pwa-node` adapter
    -- dap.adapters["pwa-node"] = {
    --   type = "server",
    --   host = "localhost",
    --   port = "${port}",
    --   executable = {
    --     command = "node",
    --     args = {
    --       "/Users/kiransilwal/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
    --       "${port}",
    --     },
    --   },
    -- }
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
    dap.adapters.dart = {
      type = "executable",
      command = "/Users/kiransilwal/Development/flutter/bin/dart", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
      args = { "debug_adapter" },
      -- windows users will need to set 'detached' to false
      options = {
        detached = false,
      },
    }
    dap.adapters.flutter = {
      type = "executable",
      command = "/Users/kiransilwal/Development/flutter/bin/flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
      args = { "debug_adapter" },
      -- windows users will need to set 'detached' to false
      options = {
        detached = false,
      },
    }

    -- Configure JavaScript/TypeScript languages
    local js_based_languages = { "", "typescript", "javascriptreact", "typescriptreact" }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- {
        --   name = "Next.js: debug server-side",
        --   type = "pwa-node",
        --   request = "attach",
        --   url = "https://localhost:3000",
        --   skipFiles = { "<node_internals>/**", "node_modules/**" },
        --   runtimeExecutable = "node",
        --   webRoot = "${workspaceFolder}",
        --   sourceMaps = true,
        --   sourceMapPathOverrides = {
        --     ["webpack://_N_E/*"] = "${webRoot}/*",
        --   },
        -- },
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "attach",
          port = 9230,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          cwd = "${workspaceFolder}",
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

    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch dart",
        dartSdkPath = "/Users/kiransilwal/Development/flutter/bin/dart", -- ensure this is correct
        flutterSdkPath = "/Users/kiransilwal/Development/flutter/bin/flutter", -- ensure this is correct
        program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
        cwd = "${workspaceFolder}",
      },
      {
        name = "Launch Flutter App",
        type = "flutter",
        request = "launch",
        dartSdkPath = "/Users/kiransilwal/Development/flutter/bin/dart", -- ensure this is correct
        flutterSdkPath = "/Users/kiransilwal/Development/flutter/bin/flutter", -- ensure this is correct
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        args = function()
          -- Get the list of connected devices
          local devices = vim.fn.systemlist("flutter devices")
          local device_list = {}

          -- Parse and extract device IDs
          for _, device in ipairs(devices) do
            local id = device:match("• (%S+)%s") -- Match device ID
            if id then
              table.insert(device_list, id)
            end
          end

          -- Prompt user to select a device
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

-- {
--   "theHamsta/nvim-dap-virtual-text", -- Virtual text
--   opts = {
--     virt_text_win_col = 80,
--   },
-- },

-- return {
--   -- Add nvim-dap
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--       dap.set_log_level("DEBUG")
--
--       -- Define `pwa-node` adapter
--       dap.adapters["pwa-node"] = {
--         type = "server",
--         host = "localhost",
--         port = "${port}",
--         executable = {
--           command = "node",
--           args = {
--             "/Users/kiransilwal/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
--             "${port}",
--           },
--         },
--       }
--
--       -- Define `chrome` adapter
--       dap.adapters["chrome"] = {
--         type = "executable",
--         command = "node",
--         args = { "/Users/kiransilwal/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
--       }
--
--       -- Add Dart/Flutter adapter (NEW)
--       dap.adapters.dart = {
--         type = "executable",
--         command = "dart",
--         args = { "debug_adapter" },
--       }
--
--       -- Configure JavaScript/TypeScript languages
--       local js_based_languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
--       for _, language in ipairs(js_based_languages) do
--         dap.configurations[language] = {
--
--           {
--             name = "Next.js: debug server-side",
--             type = "pwa-node",
--             request = "attach",
--             url = "https://localhost:3000",
--             skipFiles = { "<node_internals>/**", "node_modules/**" },
--             webRoot = vim.fn.getcwd(),
--             runtimeExecutable = "node",
--             sourceMaps = true,
--           },
--           {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require("dap.utils").pick_process,
--             cwd = "${workspaceFolder}",
--             url = "https://localhost:3000",
--             skipFiles = { "<node_internals>/**", "node_modules/**" },
--             webRoot = vim.fn.getcwd(),
--             runtimeExecutable = "node",
--             sourceMaps = true,
--           },
--           {
--             name = "Next.js: debug client-side",
--             type = "chrome",
--             request = "launch",
--             url = "http://localhost:3000",
--             webRoot = "${workspaceFolder}",
--             sourceMaps = true,
--             sourceMapPathOverrides = {
--               ["webpack://_N_E/*"] = "${webRoot}/*",
--             },
--           },
--         }
--       end
--
--       -- Add Dart/Flutter configurations (NEW)
--       dap.configurations.dart = {
--         {
--           name = "Launch Flutter App",
--           type = "dart",
--           request = "launch",
--           program = "${workspaceFolder}/lib/main.dart",
--           cwd = "${workspaceFolder}",
--           args = { "--flavor", "development" }, -- Optional Flutter build arguments
--         },
--       }
--     end,
--   },
--
--   -- Optional: Additional plugins
--   {
--     "theHamsta/nvim-dap-virtual-text", -- Virtual text
--     opts = {
--       virt_text_win_col = 80,
--     },
--   },
-- }
