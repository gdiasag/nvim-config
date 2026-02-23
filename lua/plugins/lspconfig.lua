return { -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
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
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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
        nixd = {
          manual_install = true,
          nixpkgs = {
            -- For flake.
            -- This expression will be interpreted as "nixpkgs" toplevel
            -- Nixd provides package, lib completion/information from it.
            -- Resource Usage: Entries are lazily evaluated, entire nixpkgs takes 200~300MB for just "names".
            -- Package documentation, versions, are evaluated by-need.
            expr = "import (builtins.getFlake(toString ./.)).inputs.nixpkgs {}",
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
          manual_install = true,

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
          manual_install = true,
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

      -- Removes definitions of installations that were set up to be manual.
      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      -- Ensure the servers and tools above are installed
      require("mason").setup()

      local ensure_installed = {
        "stylua",
        "lua_ls",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      local lspconfig = require("lspconfig")

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      -- require("mason-lspconfig").setup({
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       -- This handles overriding only values explicitly passed
      --       -- by the server configuration above. Useful when disabling
      --       -- certain features of an LSP (for example, turning off formatting for tsserver)
      --       server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      --       require("lspconfig")[server_name].setup(server)
      --     end,
      --   },
      -- })
    end,
  },
}
