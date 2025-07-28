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
        vtsls = false,
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
        -- jsonls = {
        --   settings = {
        --     json = {
        --       format = {
        --         enable = true,
        --       },
        --     },
        --   },
        -- },
        vhdl_ls = {},
        cssls = {},
        tailwindcss = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "html", "php" },
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("package.json")(...)
          end,
        },
        -- tsserver = {
        --   root_dir = function(...)
        --     return require("lspconfig.util").root_pattern("package.json")(...)
        --   end,
        --   single_file_support = false,
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "literal",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "all",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --   },
        --   init_options = {
        --     plugins = {
        --       {
        --         name = "@vue/typescript-plugin",
        --         location = "/opt/homebrew/lib/node_modules/@vue/language-server", -- Adjust path if necessary
        --         languages = { "vue" },
        --       },
        --     },
        --   },
        --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        -- },
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
