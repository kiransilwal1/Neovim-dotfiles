return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send request" },
    { "<leader>Ra", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests" },
    { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
    { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request" },
    { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle between request and response" },
  },
  ft = { "http", "rest" },
  opts = {
    -- Disable global keymaps, use only the ones defined above
    global_keymaps = false,
    -- Set prefix for global keymaps (not used since global_keymaps = false)
    global_keymaps_prefix = "<leader>R",
    -- Prefix for buffer-local keymaps in .http files
    kulala_keymaps_prefix = "",
    -- Additional options
    default_view = "body", -- body|headers
    debug = false,
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = { "jq", "." },
      },
      ["application/xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "-" },
      },
      ["text/html"] = {
        ft = "html",
        formatter = { "tidy", "-i", "-q", "-" },
      },
    },
    -- Updated curl options for handling redirects and SSL
    additional_curl_options = {
      "--insecure", -- Handle SSL issues with .test domains
      "--location", -- Follow redirects (equivalent to -L flag)
      "--max-redirs",
      "5", -- Limit redirects to 5
      "-A",
      "Mozilla/5.0", -- User agent
    },
  },
}
