local group = vim.api.nvim_create_augroup("config", { clear = true })

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- Reopen files at the last edit position (`:help last-position-jump`). The
-- check waits for FileType because filetype detection runs after BufRead.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(args)
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      buf = args.buf,
      once = true,
      callback = function()
        -- Commit and rebase messages are new files each time.
        local ft = vim.bo[args.buf].filetype
        if ft:find("commit") or ft == "gitrebase" or ft == "xxd" or vim.wo.diff then
          return
        end
        local line = vim.api.nvim_buf_get_mark(args.buf, '"')[1]
        if line > 1 and line <= vim.api.nvim_buf_line_count(args.buf) then
          vim.cmd('normal! g`"')
        end
      end,
    })
  end,
})
