_G.cursorword_blocklist = function()
  local curword = vim.fn.expand('<cword>')
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  -- Add any disabling global or filetype-specific logic here
  local blocklist = {}
  if filetype == 'lua' then
    blocklist = { 'local', 'require' }
  elseif filetype == 'javascript' then
    blocklist = { 'import' }
  elseif filetype == 'alpha' then
    blocklist = { '*' }
  end
  vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
end

local ok, cursorword = pcall(require, "mini.cursorword")
if not ok then
  return
end
cursorword.setup({
  -- Delay (in ms) between when cursor moved and when highlighting appeared
  delay = 100,
})
