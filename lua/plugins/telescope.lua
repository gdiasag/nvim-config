return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>h", "<Cmd>Telescope help_tags<CR>", desc = "Search help" },
      { "<leader><leader>", "<Cmd>Telescope find_files<CR>", desc = "Search files" },
      { "<leader>?", "<Cmd>Telescope live_grep<CR>", desc = "Search by grep" },
      { "<leader>g", "<Cmd>Telescope git_status<CR>", desc = "Search git changes" },
      { "<leader>dd", "<Cmd>Telescope diagnostics<CR>", desc = "Search diagnostics" },
      {
        "<leader>/",
        function()
          local themes = require("telescope.themes")
          require("telescope.builtin").current_buffer_fuzzy_find(themes.get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Fuzzily search in current buffer",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
