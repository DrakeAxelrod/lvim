-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  --   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
  -- { "ColorScheme", "*", ":hi CursorLineNr guifg=#46D9FF guibg=#282c34" },
  { "ColorScheme", "*", ":hi CursorLineNr guifg=#46D9FF" },
  { "TermClose", "*", [[call feedkeys("\<cr>")"]] },
  { "TermOpen", "*", "setlocal statusline= listchars= nonumber norelativenumber" },
  { "TermOpen", "*", "startinsert" },
  { "TermOpen", "*", ":lua vim.b.miniindentscope_disable = true" },
  { "FileType", "NvimTree,Telescope,alpha", ":lua vim.b.miniindentscope_disable = true" },
  -- Equalize window dimensions when resizing vim window
  { "VimResized", "*", [[tabdo wincmd =]] }
}
