return {
  {
    "uga-rosa/translate.nvim",
    config = function()
      vim.keymap.set("v", "<leader>t", "viw:Translate EN<CR>", {})
      vim.keymap.set("n", "<leader>tw", "viw:Translate EN<CR>", {})

      require("translate").setup({
        default = {
          command = "translate_shell",
          output = "replace",
        },
      })
    end,
  },
}
