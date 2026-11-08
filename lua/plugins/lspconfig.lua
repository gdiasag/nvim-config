return {
  {
    "neovim/nvim-lspconfig",
    -- Language servers are not installed from Neovim: global ones come from
    -- Home Manager (~/nix-config/home/neovim.nix), project ones from the
    -- project's dev shell. nvim-lspconfig only supplies default server configs.
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, rhs, desc)
            vim.keymap.set("n", keys, rhs, { buf = event.buf, desc = desc })
          end

          -- Neovim also maps grn, gra, gri, grt and gO (see `:help lsp-defaults`).
          map("gd", "<Cmd>Telescope lsp_definitions<CR>", "Go to definition")
          map("gr", "<Cmd>Telescope lsp_references<CR>", "Find references")
          map("gI", "<Cmd>Telescope lsp_implementations<CR>", "Go to implementation")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("<leader>ds", "<Cmd>Telescope lsp_document_symbols<CR>", "Search document symbols")
          map("<leader>ws", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Search workspace symbols")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          -- Neovim only maps K to hover when 'keywordprg' is unset, and the
          -- Python, Ruby, Go and Racket ftplugins (among others) set it.
          map("K", vim.lsp.buf.hover, "Hover documentation")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end
          if client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>ih", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle inlay hints")
          end
          -- ocamllsp shows inferred types as code lenses (enabled in its settings below).
          if client.name == "ocamllsp" then
            vim.lsp.codelens.enable(true, { bufnr = event.buf })
          end
        end,
      })

      -- Neovim merges these into its own default client capabilities.
      vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

      -- Servers whose executable is not on PATH (e.g. outside the matching dev
      -- shell) are simply not started.
      local servers = {
        basedpyright = {},
        clangd = {
          filetypes = { "c", "cpp" },
        },
        hls = {
          filetypes = { "haskell", "lhaskell", "cabal" },
        },
        html = {},
        lua_ls = {
          -- Neovim API types come from lazydev.nvim (lua/plugins/lazydev.lua).
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        nixd = {
          settings = {
            nixd = {
              -- <nixpkgs> is pinned by Home Manager to the config flake's nixpkgs input.
              nixpkgs = { expr = "import <nixpkgs> { }" },
              formatting = { command = { "nixfmt" } },
              options = {
                home_manager = {
                  expr = '(builtins.getFlake "'
                    .. vim.env.HOME
                    .. '/nix-config").homeConfigurations."gustavodiasag@pop-os".options',
                },
              },
            },
          },
        },
        ocamllsp = {
          settings = {
            codelens = { enable = true },
            inlayHints = { enable = true },
            syntaxDocumentation = { enable = true },
          },
        },
        -- prolog_ls = {},
        -- racket_langserver = {
        --   cmd = { "racket", "--lib", "racket-langserver" },
        --   filetypes = { "racket", "scheme" },
        -- },
        ruby_lsp = {},
        rust_analyzer = {},
        zls = {
          cmd = { vim.env.HOME .. "/code/zig/zls/zig-out/bin/zls" },
        },
      }

      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
