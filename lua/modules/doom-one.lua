-- https://github.com/NTBBloodbath/doom-one.nvim
local ok, doom_one = pcall(require, "doom_one")
if not ok then
  return
end
doom_one.setup({
  cursor_coloring = true,
  terminal_colors = true,
  italic_comments = true,
  enable_treesitter = true,
  transparent_background = true,
  pumblend = {
    enable = true,
    transparency_amount = 20,
  },
  plugins_integrations = {
    neorg = false,
    barbar = false,
    bufferline = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    neogit = false,
    nvim_tree = true,
    dashboard = false,
    startify = false,
    whichkey = true,
    indent_blankline = false,
    vim_illuminate = true,
    lspsaga = false,
  },
})
