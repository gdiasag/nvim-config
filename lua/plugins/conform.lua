return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "gofmt" },
          lua = { "stylua" },
          ocaml = { "ocamlformat" },
          rust = { "rustfmt" },
          racket = { "raco fmt" },
          ruby = { "rubyfmt" },
          python = { "black" },
        },

        formatters = {
          black = {
            prepend_args = {
              "--fast",
              "--line-length",
              "80",
            },
          },
          ocamlformat = {
            prepend_args = {
              "--if-then-else",
              "vertical",
              "--break-cases",
              "fit-or-vertical",
              "--type-decl",
              "sparse",
            },
          },
        },
      })
      -- Format on save.
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
