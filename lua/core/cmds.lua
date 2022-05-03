-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
  {"ColorScheme", "*", ":hi CursorLineNr guifg=#46D9FF guibg=#282c34" },
}
