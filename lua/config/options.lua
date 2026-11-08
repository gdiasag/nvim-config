-- Disable netrw, nvim-tree replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Format on save (lua/plugins/conform.lua). `:let g:autoformat = v:false` pauses it.
vim.g.autoformat = true
-- Keep these indentation settings in markdown buffers.
vim.g.markdown_recommended_style = 0

local o = vim.o

-- Use the system clipboard for all yanks, deletes and puts.
o.clipboard = "unnamedplus"
o.completeopt = "menu,menuone,noselect"
-- Enable highlighting of the current line.
o.cursorline = true
-- Use spaces instead of tabs.
o.expandtab = true
-- Insert indents automatically.
o.smartindent = true
-- Number of spaces tabs count for.
o.tabstop = 2
-- Size of an indent.
o.shiftwidth = 2
-- Round indent to a multiple of 'shiftwidth'.
o.shiftround = true
-- Wrap lines at convenient points.
o.linebreak = true
-- Disable line wrap.
o.wrap = false
-- Enable the mouse in all modes.
o.mouse = "a"
-- Absolute number on the cursor line, relative numbers elsewhere.
o.number = true
o.relativenumber = true
-- Always show the signcolumn, otherwise it would shift the text each time.
o.signcolumn = "yes"
-- Language used when spell checking is turned on.
o.spelllang = "en_us"
-- Use the dark variant of the colorscheme.
o.background = "dark"
-- True color support.
o.termguicolors = true
-- Save undo history to an undo file.
o.undofile = true
-- Keep a number of lines visible above/below cursor when scrolling.
o.scrolloff = 8
-- Colored column.
o.colorcolumn = "80"
-- Label tabs with the file name of their focused window (lua/config/tabline.lua).
o.tabline = "%!v:lua.require'config.tabline'.render()"

vim.diagnostic.config({
  jump = {
    -- Show the diagnostic that [d and ]d jump to in a float.
    on_jump = function(diagnostic, bufnr)
      if diagnostic then
        vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
      end
    end,
  },
})
