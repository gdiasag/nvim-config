vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy absolute path of current buffer" })

-- Centered jumps.
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page, centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page, centered" })
map("n", "O", "zzO", { desc = "Open line above, centered" })
map("n", "o", "zzo", { desc = "Open line below, centered" })

-- Diagnostics. [d and ]d are Neovim defaults (lua/config/options.lua adds the float).
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics under the cursor" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

-- Splits.
map("n", "<leader>j", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>l", "<C-w>v", { desc = "Split window right" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Tabs.
map("n", "<C-t>", "<Cmd>$tabnew<CR>", { desc = "New tab" })
map("n", "L", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "H", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Terminal.
map("n", "<leader>st", function()
  vim.cmd("botright 12new")
  vim.wo.winfixheight = true
  vim.cmd.terminal()
end, { desc = "Open terminal at the bottom" })
map("t", "<leader>xt", "<C-\\><C-n>", { desc = "Exit terminal mode" })
