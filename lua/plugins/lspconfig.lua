return { -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    -- Language servers are not installed from Neovim: global ones come from
    -- Home Manager (~/nix-config/home/neovim.nix), project ones from the
    -- project's dev shell. nvim-lspconfig only supplies default server configs.
    dependencies = {
      { "jubnzv/virtual-types.nvim" },
    },
    config = function()
      -- Configures the current buffer when a file associated with an lsp is opened,.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- Defines mappings specific for LSP related items.
          local map = function(keys, func)
            vim.keymap.set("n", keys, func, {})
          end

          -- Jump to definition.
          map("gd", require("telescope.builtin").lsp_definitions)
          -- Find references.
          map("gr", require("telescope.builtin").lsp_references)
          -- Jump to implementation.
          map("gI", require("telescope.builtin").lsp_implementations)
          -- Fuzzy find symbols in current document.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols)
          -- Fuzzy find symbols in workspace.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
          -- Rename variable.
          map("<leader>rn", vim.lsp.buf.rename)
          -- Execute a code action.
          map("<leader>ca", vim.lsp.buf.code_action)
          -- Display documentation.
          map("K", vim.lsp.buf.hover)
          -- Jump to declaration.
          map("gD", vim.lsp.buf.declaration)

          -- Inlay hints
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>ih", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end)
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Enable the following language servers
      local servers = {
        basedpyright = {},
        -- prolog_ls = {},
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
        clangd = {
          filetypes = { "c", "cpp" },
        },
        ruby_lsp = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                disable = { "missing-fields" },
                globals = { "vim" },
              },
            },
          },
        },
        ocamllsp = {
          cmd = { "ocamllsp" },

          settings = {
            codelens = { enable = true },
            inlayHints = { enable = true },
            syntaxDocumentation = { enable = true },
          },

          filetypes = {
            "ocaml",
            "ocaml.menhir",
            "ocaml.interface",
            "ocaml.ocamllex",
            "reason",
            "dune",
          },
        },

        hls = {
          cmd = {
            "haskell-language-server-wrapper",
            "--lsp",
          },
          filetypes = { "haskell", "lhaskell", "cabal" },
        },

        -- racket_langserver = {
        --   cmd = { "racket", "--lib", "racket-langserver" },
        --
        --   filetypes = { "racket", "scheme" },
        -- },

        zls = {
          cmd = {
            "/home/gustavodiasag/code/zig/zls/zig-out/bin/zls",
          },
        },
        html = {
          cmd = {
            "vscode-html-language-server",
            "--stdio",
          },
          filetypes = { "html" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
          },
        },
      }

      vim.lsp.config("*", { capabilities = capabilities })

      -- Servers whose executable is not on PATH (e.g. outside the matching dev
      -- shell) are simply not started.
      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
