local ok, surround = pcall(require, "mini.surround")
if not ok then
  return
end
-- closer to tpope/vim-surround
surround.setup({
  custom_surroundings = {
    ["("] = { output = { left = "( ", right = " )" } },
    ["["] = { output = { left = "[ ", right = " ]" } },
    ["{"] = { output = { left = "{ ", right = " }" } },
    ["<"] = { output = { left = "< ", right = " >" } },
  },
  mappings = {
    add = "ys",
    delete = "ds",
    find = "",
    find_left = "",
    highlight = "",
    replace = "cs",
    update_n_lines = "",
  },
  search_method = "cover_or_next",
})
-- Remap adding surrounding to Visual mode selection
vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

-- Make special mapping for "add surrounding for line"
vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

-- otherwise use default
-- default
-- surround.setup({
--   -- Add custom surroundings to be used on top of builtin ones. For more
--   -- information with examples, see `:h MiniSurround.config`.
--   custom_surroundings = nil,

--   -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
--   highlight_duration = 500,

--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     add = 'sa', -- Add surrounding in Normal and Visual modes
--     delete = 'sd', -- Delete surrounding
--     find = 'sf', -- Find surrounding (to the right)
--     find_left = 'sF', -- Find surrounding (to the left)
--     highlight = 'sh', -- Highlight surrounding
--     replace = 'sr', -- Replace surrounding
--     update_n_lines = 'sn', -- Update `n_lines`
--   },

--   -- Number of lines within which surrounding is searched
--   n_lines = 20,

--   -- How to search for surrounding (first inside current line, then inside
--   -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
--   -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
--   search_method = 'cover',
-- })
