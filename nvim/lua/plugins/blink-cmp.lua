return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        border = "rounded",
        max_height = 10,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    signature = {
      enabled = true,
    },
  },
}
