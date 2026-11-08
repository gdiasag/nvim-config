return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    cmd = { "PeekOpen", "PeekClose" },
    config = function()
      local peek = require("peek")
      peek.setup()
      vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
      vim.api.nvim_create_user_command("PeekClose", peek.close, {})
    end,
  },
}
