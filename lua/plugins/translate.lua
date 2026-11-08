return {
  {
    "uga-rosa/translate.nvim",
    cmd = "Translate",
    keys = {
      { "<leader>t", ":Translate EN<CR>", mode = "x", desc = "Translate selection to English" },
      { "<leader>tw", "viw:Translate EN<CR>", desc = "Translate word to English" },
    },
    opts = {
      default = {
        command = "translate_shell",
        output = "replace",
      },
    },
  },
}
