return {
  {
    -- Gives lua_ls the Neovim API and plugin types when editing this config.
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found.
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
