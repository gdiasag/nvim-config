return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    -- Loaded at startup so it can replace netrw for `nvim <directory>`.
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>t", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file tree" },
      { "<leader>H", "<Cmd>NvimTreeResize -5<CR>", desc = "Narrow file tree" },
      { "<leader>L", "<Cmd>NvimTreeResize +5<CR>", desc = "Widen file tree" },
    },
    opts = {
      git = {
        enable = false,
      },
      view = {
        relativenumber = true,
        number = true,
        width = 32,
      },
    },
  },
}
