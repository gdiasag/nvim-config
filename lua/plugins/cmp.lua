return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        -- LSP snippets expand through Neovim's built-in vim.snippet.
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        mapping = cmp.mapping.preset.insert({
          -- Select the next item
          ["<C-j>"] = cmp.mapping.select_next_item(),
          -- Select the previous item
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window back/forward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Accept the completion.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- <C-l> moves to the next placeholder of the active snippet.
          ["<C-l>"] = cmp.mapping(function()
            if vim.snippet.active({ direction = 1 }) then
              vim.snippet.jump(1)
            end
          end, { "i", "s" }),
          -- <C-h> moves to the previous one.
          ["<C-h>"] = cmp.mapping(function()
            if vim.snippet.active({ direction = -1 }) then
              vim.snippet.jump(-1)
            end
          end, { "i", "s" }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
        },
      })
    end,
  },
}
