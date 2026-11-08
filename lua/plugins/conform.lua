return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        go = { "gofmt" },
        lua = { "stylua" },
        ocaml = { "ocamlformat" },
        python = { "black" },
        racket = { "racketfmt" },
        ruby = { "rubyfmt" },
        rust = { "rustfmt" },
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

      -- Paused with `:let g:autoformat = v:false` (see lua/config/options.lua).
      format_on_save = function()
        if vim.g.autoformat then
          return {}
        end
      end,
    },
  },
}
