return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects.
    },
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")

      config.setup({
        ensure_installed = {
          "ocaml",
          "rust",
          "haskell",
          "racket",
          "typescript",
          "zig",
          "ruby",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Custom parser configs
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.cool = {
        install_info = {
          url = "~/code/c/tree-sitter-cool",
          files = { "src/parser.c", "src/scanner.c" },
        },
        filetype = "cl",
      }
    end,
  },
}
