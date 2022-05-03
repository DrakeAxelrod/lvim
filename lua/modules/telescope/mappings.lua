if not pcall(require, "telescope") then
  return
end

local wk = require("which-key")

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('plugins.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    wk.register({
      s = { key = f }
      },{
      mode = "n", -- NORMAL mode
      -- prefix: use "<leader>f" for example for mapping everything related to finding files
      -- the prefix is prepended to every mapping part of `mappings`
      prefix = "<leader>", 
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    })
    vim.keymap.set(mode, key, rhs, map_options)
  else
    wk.register({
      s = { key, rhs, f }
      },{
      mode = "n", -- NORMAL mode
      -- prefix: use "<leader>f" for example for mapping everything related to finding files
      -- the prefix is prepended to every mapping part of `mappings`
      prefix = "<leader>", 
      buffer = buffer, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    })
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.keymap.set("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
map_tele("<space>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})
map_tele("<space>f/", "grep_last_search", {
  layout_strategy = "vertical",
})

-- Files
map_tele("<space>ft", "git_files")
map_tele("<space>fg", "live_grep")
map_tele("<space>fo", "oldfiles")
map_tele("<space>fd", "fd")
map_tele("<space>pp", "project_search")
map_tele("<space>fv", "find_nvim_source")
map_tele("<space>fe", "file_browser")
map_tele("<space>fz", "search_only_certain_files")

-- Sourcegraph
map_tele("<space>sf", "sourcegraph_find")
map_tele("<space>saf", "sourcegraph_about_find")
map_tele("<space>sag", "sourcegraph_about_grep")
-- map_tele('<space>fz', 'sourcegraph_tips')

-- Git
map_tele("<space>gs", "git_status")
map_tele("<space>gc", "git_commits")

-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>fp", "my_plugins")
map_tele("<space>fa", "installed_plugins")
map_tele("<space>fi", "search_all_files")
map_tele("<space>ff", "curbuf")
map_tele("<space>fh", "help_tags")
map_tele("<space>vo", "vim_options")
map_tele("<space>gp", "grep_prompt")

-- Telescope Meta
map_tele("<space>fB", "builtin")

return map_tele
