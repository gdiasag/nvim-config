return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- The default theme, "auto", loads the colorscheme's own lualine theme.
    opts = {
      sections = {
        lualine_c = {
          { "filename", path = 1 },
        },
      },
    },
  },
}
