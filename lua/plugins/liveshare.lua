return {
  {
    "azratul/live-share.nvim",
    dependencies = {
      "jbyuki/instant.nvim",
    },

    config = function()
      -- The name collaborators see next to your cursor.
      vim.g.instant_username = vim.env.USER
      require("live-share").setup({
        port_internal = 8765,
        max_attempts = 40, -- 10 seconds
        service = "serveo.net",
      })
    end,
  },
}
