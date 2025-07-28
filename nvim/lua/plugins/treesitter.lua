return {
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSHighlightCapturesUnderCursor",
      "TSPlaygroundToggle",
      "TSNodeUnderCursor",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        playground = {
          enable = true,
          updatetime = 25,
          persist_queries = false,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      sync_install = false,
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      fold = { enable = false },
      textobjects = {
        lookahead = true,
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = "@class.outer",
            ["]f"] = "@function.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]["] = "@class.outer",
            ["]F"] = "@function.outer",
          },
          goto_previous_start = {
            ["[c"] = "@class.outer",
            ["[f"] = "@function.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["]F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          keymaps = {
            ["iC"] = "@call.inner",
            ["aC"] = "@call.outer",
            ["ic"] = "@conditional.inner",
            ["ac"] = "@conditional.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
          },
        },
        swap = { enable = false },
      },
    },
    config = function(_, opts)
      local ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "gitcommit",
        "git_config",
        "git_rebase",
        "html",
        "http",
        "javascript",
        "json",
        "php",
        "latex",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "regex",
        "ssh_config",
        "svelte",
        "typescript",
        "vimdoc",
        "php",
        "yaml",
        "astro",
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "prisma",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      local already_installed = require("nvim-treesitter.info").installed_parsers()

      local parsers_to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    branch = "main",
  },

  {
    "danymat/neogen",
    opts = {
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "numpydoc",
          },
        },
      },
    },
    config = function(_, opts)
      require("neogen").setup(opts)
      vim.keymap.set("n", "<leader>id", require("neogen").generate, {})
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local MiniSplitjoin = require("mini.splitjoin")

      local pairs = {
        "%b()",
        "%b<>",
        "%b[]",
        "%b{}",
      }

      MiniSplitjoin.setup({
        detect = {
          brackets = pairs,
          separator = "[,;]",
          exclude_regions = {},
        },
        mappings = {
          toggle = "gS",
        },
      })

      local gen_hook = MiniSplitjoin.gen_hook
      local hook_pairs = { brackets = pairs }
      local add_pair_commas = gen_hook.add_trailing_separator(hook_pairs)
      local del_pair_commas = gen_hook.del_trailing_separator(hook_pairs)
      vim.b.minisplitjoin_config = {
        split = { hooks_post = { add_pair_commas } },
        join = { hooks_post = { del_pair_commas } },
      }
    end,
  },
}

--
--
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--
--     opts = {
--       ensure_installed = {
--         "astro",
--         "bash",
--         "c",
--         "cmake",
--         "cpp",
--         "css",
--         "diff",
--         "dockerfile",
--         "gitignore",
--         "go",
--         "gomod",
--         "gosum",
--         "gowork",
--         "html",
--         "http",
--         "javascript",
--         "jsdoc",
--         "json",
--         "json5",
--         "jsonc",
--         "lua",
--         "luadoc",
--         "luap",
--         "markdown",
--         "markdown_inline",
--         "prisma",
--         "python",
--         "query",
--         "regex",
--         "sql",
--         "toml",
--         "tsx",
--         "typescript",
--         "vim",
--         "vimdoc",
--         "yaml",
--       },
--       highlight = {
--         enable = true, -- Keep Treesitter highlight enabled
--         additional_vim_regex_highlighting = false,
--       },
--       fold = { enable = false }, -- Fold setting placed directly
--       config = function(_, opts)
--         require("nvim-treesitter.configs").setup(opts)
--         -- MDX Support
--         vim.filetype.add({
--           extension = {
--             mdx = "mdx",
--           },
--         })
--         vim.treesitter.language.register("markdown", "mdx")
--       end,
--     },
--   },
--   {
--     "nvim-treesitter/playground",
--   },
--   {
--     "nvim-treesitter/nvim-treesitter-context",
--     enabled = false,
--   },
-- }
--
-- -- return {
-- --   {
-- --     "nvim-treesitter/nvim-treesitter",
-- --
-- --     opts = {
-- --       fold = { enable = false },
-- --       ensure_installed = {
-- --         "astro",
-- --         "bash",
-- --         "c",
-- --         "cmake",
-- --         "cpp",
-- --         "css",
-- --         "diff",
-- --         "dockerfile",
-- --         "gitignore",
-- --         "go",
-- --         "gomod",
-- --         "gosum",
-- --         "gowork",
-- --         "html",
-- --         "http",
-- --         "javascript",
-- --         "jsdoc",
-- --         "json",
-- --         "json5",
-- --         "jsonc",
-- --         "lua",
-- --         "luadoc",
-- --         "luap",
-- --         "markdown",
-- --         "markdown_inline",
-- --         "prisma",
-- --         "python",
-- --         "query",
-- --         "regex",
-- --         "sql",
-- --         "toml",
-- --         "tsx",
-- --         "typescript",
-- --         "vim",
-- --         "vimdoc",
-- --         "yaml",
-- --       },
-- --       config = function(_, opts)
-- --         require("nvim-treesitter.configs").setup(opts)
-- --         -- MDX
-- --         vim.filetype.add({
-- --           extension = {
-- --             mdx = "mdx",
-- --           },
-- --         })
-- --         vim.treesitter.language.register("markdown", "mdx")
-- --       end,
-- --     },
-- --   },
-- --   {
-- --     "nvim-treesitter/playground",
-- --   },
-- --   {
-- --     "nvim-treesitter/nvim-treesitter-context",
-- --     enabled = false,
-- --   },
-- -- }
