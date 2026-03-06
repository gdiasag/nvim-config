-- Auto formatting.
vim.g.autoformat = true
-- Supress deprecation warnings.
vim.g.deprecation_warnings = false
-- Whether a Nerd Font is installed and selected in the terminal.
vim.g.have_nerd_font = true
-- Fix markdown indentation settings.
vim.g.markdown_recommended_style = 0
-- Disable netwr.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.opt

o.completeopt = "menu,menuone,noselect"
-- Remap clipboard support
o.clipboard = "unnamedplus"
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
-- Wrap lines at convenient points.
o.linebreak = true
-- Enable mouse mode.
o.mouse = "a"
-- Print line number.
o.number = true
-- Relatieve line numbers.
o.relativenumber = true
-- Round indent.
o.shiftround = true
-- Always show the signcolumn, otherwise it would shift the text each time.
o.signcolumn = "yes"
-- Enable spell checking.
o.spell = false
-- Spell checking will be done for the below languages.
o.spelllang = { "en_us" }
-- Set light theme
o.background = "light"
-- True color support.
o.termguicolors = true
-- Save undo history to an undo file.
o.undofile = true
-- Disable line wrap.
o.wrap = false
-- Colored column.
o.colorcolumn = "80"
-- Custom tabline configuration.
o.tabline = "%!v:lua.MyTabLine()"

-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank({ timeout = 200 })",
})

-- Jump to last edit position on opening file.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function(_)
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      -- Except for in git commit messages:
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand("%:p"):find(".git", 1, true) then
        vim.cmd('exe "normal! g\'\\""')
      end
    end
  end,
})

-- Custom tabline configuration.
function MyTabLine()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    -- Select the highlighting
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    -- Set the tab page number
    s = s .. "%" .. i .. "T"

    -- Display just the filename (not full path)
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local filename = vim.fn.fnamemodify(vim.fn.bufname(buflist[winnr]), ":t")
    if filename == "" then
      filename = "[No Name]"
    end
    s = s .. " " .. filename .. " "
  end
  -- Fill the rest of the tabline with TabLineFill and reset tab page nr
  s = s .. "%#TabLineFill#%T"
  return s
end
