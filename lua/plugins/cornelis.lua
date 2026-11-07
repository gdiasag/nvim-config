return {
  {
    "isovector/cornelis",
    dependencies = {
      "neovimhaskell/nvim-hs.vim",
      "kana/vim-textobj-user",
    },

    name = "cornelis",
    ft = "agda",
    version = "*",
    init = function()
      -- The cornelis binary is provided by Nix instead of `stack install`.
      vim.g.cornelis_use_global_binary = 1
    end,
  },
}
