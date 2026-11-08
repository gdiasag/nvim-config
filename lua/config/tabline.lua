local M = {}

--- Tabline with one clickable label per tab: the file name of its focused window.
function M.render()
  local current = vim.api.nvim_get_current_tabpage()
  local labels = {}
  for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
    local name = vim.fs.basename(vim.api.nvim_buf_get_name(buf))
    if name == "" then
      name = "[No Name]"
    end
    local hl = tab == current and "TabLineSel" or "TabLine"
    -- %N T makes the label a click target for tab N; %% escapes a literal %.
    labels[#labels + 1] = ("%%#%s#%%%dT %s "):format(hl, i, (name:gsub("%%", "%%%%")))
  end
  return table.concat(labels) .. "%#TabLineFill#%T"
end

return M
