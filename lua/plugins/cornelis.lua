return {
  {
    "isovector/cornelis",
    dependencies = {
      "neovimhaskell/nvim-hs.vim",
      "kana/vim-textobj-user",
    },

    name = "cornelis",
    ft = "agda",
    build = "stack install",
    version = "*",
  },
}
