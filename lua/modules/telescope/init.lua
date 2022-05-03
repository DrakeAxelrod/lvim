-------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/init.lua

if not pcall(require, "telescope") then
  return
end

local should_reload = true

local reloader = function()
  if should_reload then
    RELOAD "plenary"
    RELOAD "popup"
    RELOAD "telescope"
    RELOAD "telescope.config"
    RELOAD "telescope.extra"
  end
end

reloader()

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_mt = require "telescope.actions.mt"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end
  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

pcall(require, "nvim-nonicons")

local M = {}

--[[
lua require('plenary.reload').reload_module("my_user.tele")
nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
--]]
function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/lvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

function M.find_nvim_source()
  require("telescope.builtin").find_files {
    prompt_title = "~ nvim ~",
    shorten_path = false,
    cwd = "~/build/neovim/",

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.35,
    },
  }
end

function M.edit_fish()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/fish/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.edit_shell()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/shell/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.edit_zsh()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/zsh/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.fd()
  require("telescope.builtin").fd()
end

function M.builtin()
  require("telescope.builtin").builtin()
end

function M.colorscheme()
  require("telescope.builtin.internal").colorscheme({enable_preview = true})
end

function M.git_files()
  local path = vim.fn.expand "%:h"

  local width = 0.25
  -- if string.find(path, "sourcegraph.*sourcegraph", 1, false) then
  --   width = 0.5
  -- end

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,

    cwd = path,

    layout_config = {
      width = width,
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown {
    cwd = vim.fn.expand "%:p:h",
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep()
  require("telescope").extensions.fzf_writer.staged_grep {
    shorten_path = true,
    previewer = false,
    fzf_separator = "|>",
  }
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    shorten_path = true,
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.shorten_path = true
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function M.oldfiles()
  if true then
    require("telescope").extensions.frecency.frecency()
  end
  if pcall(require("telescope").load_extension, "frecency") then
  else
    require("telescope.builtin").oldfiles { layout_strategy = "vertical" }
  end
end

-- function M.my_plugins()
--   require("telescope.builtin").find_files {
--     cwd = "~/plugins/",
--   }
-- end

function M.installed_plugins()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "data" .. "/site/pack/packer/start/",
  }
end

function M.project_search()
  require("telescope.builtin").find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("nvim_lsp.util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end

-- function M.file_browser()
--   local opts

--   opts = {
--     sorting_strategy = "ascending",
--     scroll_strategy = "cycle",
--     layout_config = {
--       prompt_position = "top",
--     },

--     attach_mappings = function(prompt_bufnr, map)
--       local current_picker = action_state.get_current_picker(prompt_bufnr)

--       local modify_cwd = function(new_cwd)
--         current_picker.cwd = new_cwd
--         current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
--       end

--       map("i", "-", function()
--         modify_cwd(current_picker.cwd .. "/..")
--       end)

--       map("i", "~", function()
--         modify_cwd(vim.fn.expand("~"))
--       end)

--       local modify_depth = function(mod)
--         return function()
--           opts.depth = opts.depth + mod

--           local current_picker = action_state.get_current_picker(prompt_bufnr)
--           current_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
--         end
--       end

--       map("i", "<M-=>", modify_depth(1))
--       map("i", "<M-+>", modify_depth(-1))

--       map("n", "yy", function()
--         local entry = action_state.get_selected_entry()
--         vim.fn.setreg("+", entry.value)
--       end)

--       return true
--     end,
--   }
--   require("telescope").extensions.file_browser.file_browser(opts)
-- end

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  require("telescope.builtin").git_status(opts)
end

function M.git_commits()
  require("telescope.builtin").git_commits {
    winblend = 5,
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
