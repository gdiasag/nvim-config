return {
  {
    "Davidyz/inlayhint-filler.nvim",
    keys = {
      {
        "<leader>I",
        function()
          require("inlayhint-filler").fill()
        end,
        desc = "Insert inlay-hint under cursor into the buffer.",
        mode = { "n", "v" },
      },
    },
  },
}
