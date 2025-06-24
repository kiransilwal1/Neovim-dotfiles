return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "vue-language-server",
        "css-lsp",
        "intelephense",
        "pyright",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        pyright = {
          root_dir = function(fname)
            return vim.loop.cwd() -- You can adjust this to a specific folder, for example, if you have a `setup.py` file.
          end,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- You can set this to "off", "basic", or "strict"
                reportAbstractMethod = "error",
                diagnosticMode = "openFilesOnly",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              format = {
                enable = true,
              },
            },
          },
        },
        vhdl_ls = {},
        cssls = {},
        tailwindcss = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "html", "php" },
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("package.json")(...)
          end,
        },
        -- volar = {
        --   filetypes = { "vue" },
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern(
        --       "vite.config.js",
        --       "package.json",
        --       "vite.config.ts",
        --       "nuxt.config.js",
        --       "nuxt.config.ts"
        --     )(...)
        --   end,
        --   settings = {
        --     volar = {
        --       autoCompleteRefs = true,
        --     },
        --   },
        --   init_options = {
        --     vue = {
        --       hybridMode = false,
        --     },
        --     typescript = {
        --       tsdk = function(root_dir)
        --         local local_tsdk_path = root_dir and root_dir .. "/node_modules/typescript/lib"
        --         local global_tsdk_path = "/opt/homebrew/lib/node_modules/typescript/lib" -- Adjusted to match the global path
        --         -- Check if the local TypeScript exists; fallback to global if not
        --         if local_tsdk_path and vim.fn.isdirectory(local_tsdk_path) == 1 then
        --           return local_tsdk_path
        --         else
        --           return global_tsdk_path
        --         end
        --       end,
        --     },
        --   },
        -- },

        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("package.json")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/opt/homebrew/lib/node_modules/@vue/language-server", -- Adjust path if necessary
                languages = { "vue" },
              },
            },
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        },
        html = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "php" },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      intelephense = {
        root_dir = require("lspconfig").util.root_pattern(".git", "package.json", "wp-config.php"),
        settings = {
          intelephense = {
            environment = {
              include = { vim.fn.getcwd() .. "/vendor/**/*.php" }, -- Attach from the current working directory
            },
            stubs = {
              "bcmath",
              "bz2",
              "calendar",
              "Core",
              "curl",
              "date",
              "dba",
              "dom",
              "enchant",
              "fileinfo",
              "filter",
              "ftp",
              "gd",
              "gettext",
              "hash",
              "iconv",
              "imap",
              "intl",
              "json",
              "ldap",
              "libxml",
              "mbstring",
              "mcrypt",
              "mysql",
              "mysqli",
              "password",
              "pcntl",
              "pcre",
              "PDO",
              "pdo_mysql",
              "Phar",
              "readline",
              "recode",
              "Reflection",
              "regex",
              "session",
              "SimpleXML",
              "soap",
              "sockets",
              "sodium",
              "SPL",
              "standard",
              "superglobals",
              "sysvsem",
              "sysvshm",
              "tokenizer",
              "xml",
              "xdebug",
              "xmlreader",
              "xmlwriter",
              "yaml",
              "zip",
              "zlib",
              "wordpress",
              "woocommerce",
              "acf-pro",
              "acf-stubs",
              "wordpress-globals",
              "wp-cli",
              "genesis",
              "polylang",
              "sbi",
            },
            -- cmd = { vim.fn.stdpath("data") .. "/mason/packages/intelephense", "--stdio" },
            files = {
              maxSize = 500000000, -- Increase max file size limit
            },
          },
        },
      },
      setup = {},
    },
  },
}

-- return {
--   -- tools
--   {
--     "williamboman/mason.nvim",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "stylua",
--         "selene",
--         "luacheck",
--         "shellcheck",
--         "shfmt",
--         "tailwindcss-language-server",
--         "typescript-language-server",
--         "css-lsp",
--         "vtsls",
--         "emmet-ls", -- Added for HTML and JSX autocompletion
--       })
--     end,
--   },
--
--   -- lsp servers
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = { "saghen/blink.cmp" },
--     opts = {
--       inlay_hints = { enabled = false },
--       ---@type lspconfig.options
--       servers = {
--         cssls = {},
--         tailwindcss = {
--           root_dir = function(...)
--             return require("lspconfig.util").root_pattern(".git")(...)
--           end,
--         },
--         vtsls = {
--           root_dir = function(...)
--             return require("lspconfig.util").root_pattern(".git")(...)
--           end,
--           single_file_support = true,
--           settings = {
--             typescript = {
--               inlayHints = {
--                 includeInlayParameterNameHints = "literal",
--                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                 includeInlayFunctionParameterTypeHints = true,
--                 includeInlayVariableTypeHints = false,
--                 includeInlayPropertyDeclarationTypeHints = true,
--                 includeInlayFunctionLikeReturnTypeHints = true,
--                 includeInlayEnumMemberValueHints = true,
--               },
--             },
--             javascript = {
--               inlayHints = {
--                 includeInlayParameterNameHints = "all",
--                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--                 includeInlayFunctionParameterTypeHints = true,
--                 includeInlayVariableTypeHints = true,
--                 includeInlayPropertyDeclarationTypeHints = true,
--                 includeInlayFunctionLikeReturnTypeHints = true,
--                 includeInlayEnumMemberValueHints = true,
--               },
--             },
--           },
--         },
--         -- tsserver = {
--         --   root_dir = function(...)
--         --     return require("lspconfig.util").root_pattern(".git")(...)
--         --   end,
--         --   single_file_support = true,
--         --   settings = {
--         --     typescript = {
--         --       inlayHints = {
--         --         includeInlayParameterNameHints = "literal",
--         --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         --         includeInlayFunctionParameterTypeHints = true,
--         --         includeInlayVariableTypeHints = false,
--         --         includeInlayPropertyDeclarationTypeHints = true,
--         --         includeInlayFunctionLikeReturnTypeHints = true,
--         --         includeInlayEnumMemberValueHints = true,
--         --       },
--         --     },
--         --     javascript = {
--         --       inlayHints = {
--         --         includeInlayParameterNameHints = "all",
--         --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         --         includeInlayFunctionParameterTypeHints = true,
--         --         includeInlayVariableTypeHints = true,
--         --         includeInlayPropertyDeclarationTypeHints = true,
--         --         includeInlayFunctionLikeReturnTypeHints = true,
--         --         includeInlayEnumMemberValueHints = true,
--         --       },
--         --     },
--         --   },
--         -- },
--         html = {
--           capabilities = require("blink.cmp").get_lsp_capabilities(), -- Ensure enhanced capabilities
--         },
--         yamlls = {
--           settings = {
--             yaml = {
--               keyOrdering = false,
--             },
--           },
--         },
--         lua_ls = {
--           single_file_support = true,
--           settings = {
--             Lua = {
--               workspace = {
--                 checkThirdParty = false,
--               },
--               completion = {
--                 workspaceWord = true,
--                 callSnippet = "Both",
--               },
--               misc = {
--                 parameters = {
--                   -- "--log-level=trace",
--                 },
--               },
--               hint = {
--                 enable = true,
--                 setType = false,
--                 paramType = true,
--                 paramName = "Disable",
--                 semicolon = "Disable",
--                 arrayIndex = "Disable",
--               },
--               doc = {
--                 privateName = { "^_" },
--               },
--               type = {
--                 castNumberToInteger = true,
--               },
--               diagnostics = {
--                 disable = { "incomplete-signature-doc", "trailing-space" },
--                 groupSeverity = {
--                   strong = "Warning",
--                   strict = "Warning",
--                 },
--                 groupFileStatus = {
--                   ["ambiguity"] = "Opened",
--                   ["await"] = "Opened",
--                   ["codestyle"] = "None",
--                   ["duplicate"] = "Opened",
--                   ["global"] = "Opened",
--                   ["luadoc"] = "Opened",
--                   ["redefined"] = "Opened",
--                   ["strict"] = "Opened",
--                   ["strong"] = "Opened",
--                   ["type-check"] = "Opened",
--                   ["unbalanced"] = "Opened",
--                   ["unused"] = "Opened",
--                 },
--                 unusedLocalExclude = { "_*" },
--               },
--               format = {
--                 enable = false,
--                 defaultConfig = {
--                   indent_style = "space",
--                   indent_size = "2",
--                   continuation_indent_size = "2",
--                 },
--               },
--             },
--           },
--         },
--         emmet_ls = {
--           capabilities = require("blink.cmp").get_lsp_capabilities(),
--           filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
--         },
--       },
--       setup = {},
--     },
--     config = function(_, opts)
--       local lspconfig = require("lspconfig")
--       local blink_cmp = require("blink.cmp")
--
--       -- Enhance capabilities with blink.cmp
--       local default_capabilities = blink_cmp.get_lsp_capabilities()
--       for server, config in pairs(opts.servers) do
--         -- passing config.capabilities to blink.cmp merges with the capabilities in your
--         -- `opts[server].capabilities, if you've defined it
--         config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
--         lspconfig[server].setup(config)
--       end
--
--       -- for server, server_opts in pairs(opts.servers) do
--       --   server_opts.capabilities = vim.tbl_deep_extend("force", default_capabilities, server_opts.capabilities or {})
--       --   lspconfig[server].setup(server_opts)
--       -- end
--
--       -- Additional setup logic (if any)
--       if opts.setup then
--         for server, setup_func in pairs(opts.setup) do
--           setup_func(lspconfig[server])
--         end
--       end
--     end,
--   },
-- }
--
-- -- return {
-- --   -- tools
-- --   {
-- --     "williamboman/mason.nvim",
-- --     opts = function(_, opts)
-- --       vim.list_extend(opts.ensure_installed, {
-- --         "stylua",
-- --         "selene",
-- --         "luacheck",
-- --         "shellcheck",
-- --         "shfmt",
-- --         "tailwindcss-language-server",
-- --         "typescript-language-server",
-- --         "css-lsp",
-- --         "emmet-ls",
-- --         "vtsls",
-- --       })
-- --     end,
-- --   },
-- --
-- --   -- lsp servers
-- --   {
-- --     "neovim/nvim-lspconfig",
-- --     opts = {
-- --       inlay_hints = { enabled = false },
-- --       ---@type lspconfig.options
-- --       servers = {
-- --         cssls = {},
-- --         tailwindcss = {
-- --           root_dir = function(...)
-- --             return require("lspconfig.util").root_pattern(".git")(...)
-- --           end,
-- --         },
-- --         vtsls = {
-- --           root_dir = function(...)
-- --             return require("lspconfig.util").root_pattern(".git")(...)
-- --           end,
-- --           single_file_support = true,
-- --           settings = {
-- --             typescript = {
-- --               preferences = {
-- --                 includeCompletionsForModuleExports = true,
-- --                 includeCompletionsForImportStatements = true,
-- --               },
-- --             },
-- --             javascript = {
-- --               preferences = {
-- --                 includeCompletionsForModuleExports = true,
-- --                 includeCompletionsForImportStatements = true,
-- --               },
-- --             },
-- --           },
-- --         },
-- --
-- --         html = {},
-- --         yamlls = {
-- --           settings = {
-- --             yaml = {
-- --               keyOrdering = false,
-- --             },
-- --           },
-- --         },
-- --         lua_ls = {
-- --           -- enabled = false,
-- --           single_file_support = true,
-- --           settings = {
-- --             Lua = {
-- --               workspace = {
-- --                 checkThirdParty = false,
-- --               },
-- --               completion = {
-- --                 workspaceWord = true,
-- --                 callSnippet = "Both",
-- --               },
-- --               misc = {
-- --                 parameters = {
-- --                   -- "--log-level=trace",
-- --                 },
-- --               },
-- --               hint = {
-- --                 enable = true,
-- --                 setType = false,
-- --                 paramType = true,
-- --                 paramName = "Disable",
-- --                 semicolon = "Disable",
-- --                 arrayIndex = "Disable",
-- --               },
-- --               doc = {
-- --                 privateName = { "^_" },
-- --               },
-- --               type = {
-- --                 castNumberToInteger = true,
-- --               },
-- --               diagnostics = {
-- --                 disable = { "incomplete-signature-doc", "trailing-space" },
-- --                 -- enable = false,
-- --                 groupSeverity = {
-- --                   strong = "Warning",
-- --                   strict = "Warning",
-- --                 },
-- --                 groupFileStatus = {
-- --                   ["ambiguity"] = "Opened",
-- --                   ["await"] = "Opened",
-- --                   ["codestyle"] = "None",
-- --                   ["duplicate"] = "Opened",
-- --                   ["global"] = "Opened",
-- --                   ["luadoc"] = "Opened",
-- --                   ["redefined"] = "Opened",
-- --                   ["strict"] = "Opened",
-- --                   ["strong"] = "Opened",
-- --                   ["type-check"] = "Opened",
-- --                   ["unbalanced"] = "Opened",
-- --                   ["unused"] = "Opened",
-- --                 },
-- --                 unusedLocalExclude = { "_*" },
-- --               },
-- --               format = {
-- --                 enable = false,
-- --                 defaultConfig = {
-- --                   indent_style = "space",
-- --                   indent_size = "2",
-- --                   continuation_indent_size = "2",
-- --                 },
-- --               },
-- --             },
-- --           },
-- --         },
-- --       },
-- --       setup = {},
-- --     },
-- --   },
-- --   {
-- --     "neovim/nvim-lspconfig",
-- --     opts = function()
-- --       local keys = require("lazyvim.plugins.lsp.keymaps").get()
-- --       vim.list_extend(keys, {
-- --         {
-- --           "gd",
-- --           function()
-- --             -- DO NOT RESUSE WINDOW
-- --             require("telescope.builtin").lsp_definitions({ reuse_win = false })
-- --           end,
-- --           desc = "Goto Definition",
-- --           has = "definition",
-- --         },
-- --       })
-- --     end,
-- --   },
-- -- }
--
-- -- return {
-- --   "VonHeikemen/lsp-zero.nvim",
-- --   branch = "v2.x",
-- --   dependencies = {
-- --     -- LSP Support
-- --     { "neovim/nvim-lspconfig" }, -- Required
-- --     { -- Optional
-- --       "williamboman/mason.nvim",
-- --       build = function()
-- --         pcall(vim.cmd, "MasonUpdate")
-- --       end,
-- --     },
-- --     { "williamboman/mason-lspconfig.nvim" }, -- Optional
-- --
-- --     -- Autocompletion
-- --     { "hrsh7th/nvim-cmp" }, -- Required
-- --     { "hrsh7th/cmp-nvim-lsp" }, -- Required
-- --     { "L3MON4D3/LuaSnip" }, -- Required
-- --     { "rafamadriz/friendly-snippets" },
-- --     { "hrsh7th/cmp-buffer" },
-- --     { "hrsh7th/cmp-path" },
-- --     { "hrsh7th/cmp-cmdline" },
-- --     { "saadparwaiz1/cmp_luasnip" },
-- --   },
-- --   config = function()
-- --     local lsp = require("lsp-zero")
-- --
-- --     lsp.on_attach(function(client, bufnr)
-- --       local opts = { buffer = bufnr, remap = false }
-- --
-- --       vim.keymap.set("n", "gr", function()
-- --         vim.lsp.buf.references()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
-- --       vim.keymap.set("n", "gd", function()
-- --         vim.lsp.buf.definition()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
-- --       vim.keymap.set("n", "K", function()
-- --         vim.lsp.buf.hover()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
-- --       vim.keymap.set("n", "<leader>vws", function()
-- --         vim.lsp.buf.workspace_symbol()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
-- --       vim.keymap.set("n", "<leader>vd", function()
-- --         vim.diagnostic.setloclist()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
-- --       vim.keymap.set("n", "[d", function()
-- --         vim.diagnostic.goto_next()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
-- --       vim.keymap.set("n", "]d", function()
-- --         vim.diagnostic.goto_prev()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
-- --       vim.keymap.set("n", "<leader>vca", function()
-- --         vim.lsp.buf.code_action()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
-- --       vim.keymap.set("n", "<leader>vrr", function()
-- --         vim.lsp.buf.references()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
-- --       vim.keymap.set("n", "<leader>vrn", function()
-- --         vim.lsp.buf.rename()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
-- --       vim.keymap.set("i", "<C-h>", function()
-- --         vim.lsp.buf.signature_help()
-- --       end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
-- --     end)
-- --
-- --     require("mason").setup({})
-- --     require("mason-lspconfig").setup({
-- --       ensure_installed = {
-- --         "typescript-language-server",
-- --         "eslint",
-- --         "rust_analyzer",
-- --         "kotlin_language_server",
-- --         "jdtls",
-- --         "lua_ls",
-- --         "jsonls",
-- --         "html",
-- --         "elixirls",
-- --         "tailwindcss",
-- --         "tflint",
-- --         "pylsp",
-- --         "dockerls",
-- --         "bashls",
-- --         "marksman",
-- --         "solargraph",
-- --         "cucumber_language_server",
-- --         "gopls",
-- --         "astro",
-- --       },
-- --       handlers = {
-- --         lsp.default_setup,
-- --         lua_ls = function()
-- --           local lua_opts = lsp.nvim_lua_ls()
-- --           require("lspconfig").lua_ls.setup(lua_opts)
-- --         end,
-- --       },
-- --     })
-- --
-- --     local cmp_action = require("lsp-zero").cmp_action()
-- --     local cmp = require("cmp")
-- --     local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- --
-- --     require("luasnip.loaders.from_vscode").lazy_load()
-- --
-- --     -- `/` cmdline setup.
-- --     cmp.setup.cmdline("/", {
-- --       mapping = cmp.mapping.preset.cmdline(),
-- --       sources = {
-- --         { name = "buffer" },
-- --       },
-- --     })
-- --
-- --     -- `:` cmdline setup.
-- --     cmp.setup.cmdline(":", {
-- --       mapping = cmp.mapping.preset.cmdline(),
-- --       sources = cmp.config.sources({
-- --         { name = "path" },
-- --       }, {
-- --         {
-- --           name = "cmdline",
-- --           option = {
-- --             ignore_cmds = { "Man", "!" },
-- --           },
-- --         },
-- --       }),
-- --     })
-- --
-- --     cmp.setup({
-- --       snippet = {
-- --         expand = function(args)
-- --           require("luasnip").lsp_expand(args.body)
-- --         end,
-- --       },
-- --       sources = {
-- --         { name = "nvim_lsp" },
-- --         { name = "luasnip", keyword_length = 2 },
-- --         { name = "buffer", keyword_length = 3 },
-- --         { name = "path" },
-- --       },
-- --       mapping = cmp.mapping.preset.insert({
-- --         ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- --         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- --         ["<CR>"] = cmp.mapping.confirm({ select = true }),
-- --         ["<C-Space>"] = cmp.mapping.complete(),
-- --         ["<C-f>"] = cmp_action.luasnip_jump_forward(),
-- --         ["<C-b>"] = cmp_action.luasnip_jump_backward(),
-- --         ["<Tab>"] = cmp_action.luasnip_supertab(),
-- --         ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
-- --       }),
-- --     })
-- --   end,
-- -- }
-- -- -- Disable "No information available" notification on hover
-- -- -- plus define border for hover window
-- -- -- vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
-- -- --   config = config
-- -- --     or {
-- -- --       border = {
-- -- --         { "╭", "Comment" },
-- -- --         { "─", "Comment" },
-- -- --         { "╮", "Comment" },
-- -- --         { "│", "Comment" },
-- -- --         { "╯", "Comment" },
-- -- --         { "─", "Comment" },
-- -- --         { "╰", "Comment" },
-- -- --         { "│", "Comment" },
-- -- --       },
-- -- --     }
-- -- --   config.focus_id = ctx.method
-- -- --   if not (result and result.contents) then
-- -- --     return
-- -- --   end
-- -- --   local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
-- -- --   markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
-- -- --   if vim.tbl_isempty(markdown_lines) then
-- -- --     return
-- -- --   end
-- -- --   return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
-- -- -- end
-- -- --
-- -- -- return {
-- -- --   {
-- -- --     "neovim/nvim-lspconfig",
-- -- --     opts = {
-- -- --       servers = {
-- -- --         vtsls = {
-- -- --           settings = {
-- -- --             typescript = {
-- -- --               inlayHints = {
-- -- --                 enumMemberValues = { enabled = false },
-- -- --                 functionLikeReturnTypes = { enabled = false },
-- -- --                 parameterNames = { enabled = false },
-- -- --                 parameterTypes = { enabled = false },
-- -- --                 propertyDeclarationTypes = { enabled = false },
-- -- --                 variableTypes = { enabled = false },
-- -- --               },
-- -- --             },
-- -- --           },
-- -- --         },
-- -- --         gopls = {
-- -- --           settings = {
-- -- --             gopls = {
-- -- --               hints = {
-- -- --                 assignVariableTypes = false,
-- -- --                 compositeLiteralFields = false,
-- -- --                 compositeLiteralTypes = false,
-- -- --                 constantValues = false,
-- -- --                 functionTypeParameters = false,
-- -- --                 parameterNames = false,
-- -- --                 rangeVariableTypes = false,
-- -- --               },
-- -- --             },
-- -- --           },
-- -- --         },
-- -- --       },
-- -- --     },
-- -- --   },
-- -- -- }
