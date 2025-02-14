return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "astro-language-server",
        "intelephense",
        "bash-language-server",
        "chrome-debug-adapter",
        "clangd",
        "cmakelang",
        "cmakelint",
        "codelldb",
        "css-lsp",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "emmet-ls",
        "gofumpt",
        "goimports",
        "gopls",
        "hadolint",
        "java-test",
        "jdtls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint",
        "markdownlint-cli2",
        "marksman",
        "neocmakelsp",
        "prettier",
        "prettierd",
        "prisma-language-server",
        "pyright",
        "ruff",
        "ruff-lsp",
        "selene",
        "shellcheck",
        "shfmt",
        "sql-formatter",
        "sqlfluff",
        "stylua",
        "tailwindcss-language-server",
        "terraform-ls",
        "tflint",
        "vtsls",
        "yaml-language-server",
        "vue-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "debugpy",
          "flake8",
          "isort",
          "mypy",
          "pylint",
        },
      })
    end,
  },
  {
    "psf/black",
    ft = "python",
    config = function()
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.py",
        callback = function()
          vim.cmd("Black")
        end,
      })
    end,
  },
  {
    "fisadev/vim-isort",
    ft = "python",
    config = function()
      vim.g.vim_isort_map = ""
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.py",
        callback = function()
          vim.cmd("Isort")
        end,
      })
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "php" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
}
