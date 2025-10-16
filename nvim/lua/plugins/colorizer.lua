return {
  "catgoose/nvim-colorizer.lua",
  opts = {
    filetypes = {
      css = {
        names = true,
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        -- This enables CSS custom properties/variables
        sass = { enable = true },
      },
      js = { names = false },
      lua = { names = false },
      markdown = { names = false },
      text = { names = false },
    },
    user_default_options = {
      -- Enable CSS custom properties globally
      css = true,
      css_fn = true,
      -- This helps with CSS variables
      sass = { enable = true },
    },
  },
}
