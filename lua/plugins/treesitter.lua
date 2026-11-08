return {
  {
    -- The `main` branch is the rewrite for Neovim 0.12+; `master` is frozen at 0.11.
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- `main` does not support lazy-loading.
    build = ":TSUpdate",
    config = function()
      -- Local grammar for COOL (filetype `cool`, see lua/config/filetype.lua).
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").cool = {
            install_info = { path = "~/code/c/tree-sitter-cool" },
          }
        end,
      })

      -- No-op for parsers that are already installed.
      require("nvim-treesitter").install({
        "cool",
        "haskell",
        "ocaml",
        "racket",
        "ruby",
        "rust",
        "typescript",
        "zig",
      })

      -- Highlighting for every filetype that has a parser, and indentation
      -- where the language ships an indents query.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not (lang and pcall(vim.treesitter.start, args.buf, lang)) then
            return
          end
          if vim.treesitter.query.get(lang, "indents") then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
