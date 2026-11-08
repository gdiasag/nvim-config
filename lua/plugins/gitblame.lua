return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ou", "<Cmd>GitBlameOpenCommitURL<CR>", desc = "Open commit URL of current line" },
    },
    opts = {
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
}
