return {
  {
    "nvim-treesitter/nvim-treesitter",

    opts = {
      ensure_installed = {
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
      },
      highlight = {
        enable = true, -- Keep Treesitter highlight enabled
        additional_vim_regex_highlighting = false,
      },
      fold = { enable = false }, -- Fold setting placed directly
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        -- MDX Support
        vim.filetype.add({
          extension = {
            mdx = "mdx",
          },
        })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },
  },
  {
    "nvim-treesitter/playground",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
}

-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--
--     opts = {
--       fold = { enable = false },
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
--       config = function(_, opts)
--         require("nvim-treesitter.configs").setup(opts)
--         -- MDX
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
