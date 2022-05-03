if not pcall(require, "telescope") then
  return
end
local lvim = lvim
local join_paths = join_paths
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

lvim.builtin.telescope.defaults.initial_mode = "insert"
-- lvim.builtin.telescope.defaults.prompt_prefix = " "
-- lvim.builtin.telescope.defaults.selection_caret = " "
lvim.builtin.telescope.defaults.prompt_prefix = "> "
lvim.builtin.telescope.defaults.selection_caret = "> "
lvim.builtin.telescope.defaults.entry_prefix = "  "
lvim.builtin.telescope.defaults.multi_icon = "<>"
lvim.builtin.telescope.defaults.winblend = 0
lvim.builtin.telescope.defaults.entry_prefix = "  "
lvim.builtin.telescope.defaults.file_ignore_patterns = {}
lvim.builtin.telescope.defaults.path_display = {
  shorten = 5,
}
lvim.builtin.telescope.defaults.border = true
lvim.builtin.telescope.defaults.borderchars = {
  "─", "│", "─", "│", "╭", "╮", "╯", "╰"
}
lvim.builtin.telescope.defaults.color_devicons = true
lvim.builtin.telescope.defaults.set_env = {
  ["COLORTERM"] = "truecolor"
} -- default = nil,
lvim.builtin.telescope.defaults.selection_strategy = "reset"
lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.scroll_strategy = "cycle"
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.wrap_results = false
lvim.builtin.telescope.defaults.dynamic_preview_title = true
lvim.builtin.telescope.defaults.treesitter = true

lvim.builtin.telescope.defaults.file_previewer = require("telescope.previewers").vim_buffer_cat.new
lvim.builtin.telescope.defaults.grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new
lvim.builtin.telescope.defaults.qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new

-- lvim.builtin.telescope.defaults.layout_config = {
--   width = 0.90,
--   preview_cutoff = 120,
--   horizontal = {
--     preview_width = function(_, cols, _)
--       if cols < 120 then
--         return math.floor(cols * 0.5)
--       end
--       return math.floor(cols * 0.6)
--     end,
--     mirror = false,
--   },
--   vertical = { mirror = false },
-- }

lvim.builtin.telescope.defaults.layout_config = {
  width = 0.95,
  height = 0.85,
  -- preview_cutoff = 120,
  prompt_position = "top",

  horizontal = {
    -- width_padding = 0.1,
    -- height_padding = 0.1,
    preview_width = function(_, cols, _)
      if cols > 200 then
        return math.floor(cols * 0.4)
      else
        return math.floor(cols * 0.6)
      end
    end,
  },

  vertical = {
    -- width_padding = 0.05,
    -- height_padding = 1,
    width = 0.9,
    height = 0.95,
    preview_height = 0.5,
  },

  flex = {
    horizontal = {
      preview_width = 0.9,
    },
  },
}

lvim.builtin.telescope.defaults.vimgrep_arguments = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",
  "--glob=!.git/",
}

local ok, actions = pcall(require, "telescope.actions")
if not ok then
  return
end
local fb_actions = require("telescope").extensions.file_browser.actions


lvim.builtin.telescope.defaults.mappings = {
  i = {
    -- IMPORTANT
    -- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
    -- ["<C-space>"] = R("telescope").extensions.hop.hop,  -- hop.hop_toggle_selection
    -- custom hop loop to multi selects and sending selected entries to quickfix list 
    -- ["<C-space>"] = function(prompt_bufnr)
    --   local opts = {
    --     callback = actions.toggle_selection,
    --     loop_callback = actions.send_selected_to_qflist,
    --   }
    --   require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
    -- end,

    -- ["<C-x>"] = false,
    ["<C-s>"] = actions.select_horizontal,

    -- ["<C-y>"] = set_prompt_to_entry_value,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-c>"] = actions.close,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

    -- ["<C-n>"] = actions.move_selection_next,
    -- ["<C-p>"] = actions.move_selection_previous,

    -- ["<C-c>"] = actions.close,

    -- ["<Down>"] = actions.move_selection_next,
    -- ["<Up>"] = actions.move_selection_previous,

    -- ["<CR>"] = actions.select_default,
    -- ["<C-x>"] = actions.select_horizontal,
    -- ["<C-v>"] = actions.select_vertical,
    -- ["<C-t>"] = actions.select_tab,

    -- ["<C-u>"] = actions.preview_scrolling_up,
    -- ["<C-d>"] = actions.preview_scrolling_down,

    -- ["<PageUp>"] = actions.results_scrolling_up,
    -- ["<PageDown>"] = actions.results_scrolling_down,

    -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    -- ["<C-l>"] = actions.complete_tag,
    -- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    -- ["<C-w>"] = { "<c-s-w>", type = "command" },
    ["<C-/>"] = "which_key",
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,

    -- ["<esc>"] = actions.close,
    -- ["<CR>"] = actions.select_default,
    -- ["<C-x>"] = actions.select_horizontal,
    -- ["<C-v>"] = actions.select_vertical,
    -- ["<C-t>"] = actions.select_tab,

    -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

    -- -- TODO: This would be weird if we switch the ordering.
    -- ["j"] = actions.move_selection_next,
    -- ["k"] = actions.move_selection_previous,
    -- ["H"] = actions.move_to_top,
    -- ["M"] = actions.move_to_middle,
    -- ["L"] = actions.move_to_bottom,

    -- ["<Down>"] = actions.move_selection_next,
    -- ["<Up>"] = actions.move_selection_previous,
    -- ["gg"] = actions.move_to_top,
    -- ["G"] = actions.move_to_bottom,

    -- ["<C-u>"] = actions.preview_scrolling_up,
    -- ["<C-d>"] = actions.preview_scrolling_down,

    -- ["<PageUp>"] = actions.results_scrolling_up,
    -- ["<PageDown>"] = actions.results_scrolling_down,
    ["?"] = "which_key",
  },
}

lvim.builtin.telescope.defaults.history = {
  path = join_paths(vim.fn.stdpath("data"), "telescope_history.sqlite3"),
  limit = 100,
}

lvim.builtin.telescope.defaults.pickers.find_files = {
  find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
}

lvim.builtin.telescope.defaults.pickers.find_files.live_grep = {
  --@usage don't include the filename in the search results
  -- only_sort_text = true,
}

lvim.builtin.telescope.defaults.pickers.fd = {
  mappings = {
    n = {
      ["kj"] = "close",
    },
  },
}

lvim.builtin.telescope.defaults.pickers.git_branches = {
  mappings = {
    i = {
      ["<C-a>"] = false,
    },
  },
}

lvim.builtin.telescope.defaults.extensions = {}
-- <A-c>/c	Create file/folder at current path (trailing path separator creates folder)
-- <A-r>/r	Rename multi-selected files/folders
-- <A-m>/m	Move multi-selected files/folders to current path
-- <A-y>/y	Copy (multi-)selected files/folders to current path
-- <A-d>/d	Delete (multi-)selected files/folders
-- <C-o>/o	Open file/folder with default system application
-- <C-g>/g	Go to parent directory
-- <C-e>/e	Go to home directory
-- <C-w>/w	Go to current working directory (cwd)
-- <C-t>/t	Change nvim's cwd to selected folder/file(parent)
-- <C-f>/f	Toggle between file and folder browser
-- <C-h>/h	Toggle hidden files/folders
-- <C-s>/s	Toggle all entries ignoring ./ and ../
lvim.builtin.telescope.defaults.extensions.file_browser = {
  grouped = true,
  cwd_to_path = true,
  mappings = {
    ["i"] = {
      -- Create file/folder at current path (trailing path separator creates folder)
      ["<A-c>"] = fb_actions.create,
      -- Rename multi-selected files/folders
      ["<A-r>"] = fb_actions.rename,
      -- Move multi-selected files/folders to current path
      ["<A-m>"] = fb_actions.move,
      -- Copy (multi-)selected files/folders to current path
      ["<A-y>"] = fb_actions.copy,
      -- Delete (multi-)selected files/folders
      ["<A-d>"] = fb_actions.remove,
      -- Open file/folder with default system application
      ["<C-o>"] = fb_actions.open,
      -- Go to parent directory
      ["<A-g>"] = fb_actions.goto_parent_dir,
      -- Go to home directory
      ["<A-h>"] = fb_actions.goto_home_dir,
      -- Go to current working directory (cwd)
      ["<C-w>"] = fb_actions.goto_cwd,
      -- Change nvim's cwd to selected folder/file(parent)
      ["<C-t>"] = fb_actions.change_cwd,
      -- Toggle between file and folder browser
      ["<C-f>"] = fb_actions.toggle_browser,
      -- Toggle hidden files/folders
      ["<C-.>"] = fb_actions.toggle_hidden,
      -- Toggle all entries ignoring ./ and ../
      ["<C-s>"] = fb_actions.toggle_all,
      -- toggle whichkey help
      ["<C-/>"] = "which_key",
    },
    ["n"] = {
      -- Create file/folder at current path (trailing path separator creates folder)
      ["c"] = fb_actions.create,
      -- Rename multi-selected files/folders
      ["r"] = fb_actions.rename,
      -- Move multi-selected files/folders to current path
      ["m"] = fb_actions.move,
      -- Copy (multi-)selected files/folders to current path
      ["y"] = fb_actions.copy,
      -- Delete (multi-)selected files/folders
      ["d"] = fb_actions.remove,
      -- Open file/folder with default system application
      ["o"] = fb_actions.open,
      -- Go to parent directory
      ["g"] = fb_actions.goto_parent_dir,
      -- Go to home directory
      ["e"] = fb_actions.goto_home_dir,
      -- Go to current working directory (cwd)
      ["w"] = fb_actions.goto_cwd,
      -- Change nvim's cwd to selected folder/file(parent)
      ["t"] = fb_actions.change_cwd,
      -- Toggle between file and folder browser
      ["f"] = fb_actions.toggle_browser,
      -- Toggle hidden files/folders
      ["h"] = fb_actions.toggle_hidden,
      -- Toggle all entries ignoring ./ and ../
      ["s"] = fb_actions.toggle_all,
      -- toggle whichkey help
      ["?"] = "which_key",
    },
  },
}

lvim.builtin.telescope.extensions.fzy_native = {
  override_generic_sorter = true,
  override_file_sorter = true,
}

lvim.builtin.telescope.extensions.fzf_writer = {
  use_highlighter = false,
  minimum_grep_characters = 6,
}


-- lvim.builtin.telescope.extensions.media_files = {
--   -- filetypes whitelist
--   -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
--   filetypes = { "png", "webp", "jpg", "jpeg" },
--   find_cmd = "rg", -- find command (defaults to `fd`)
-- }

-- lvim.builtin.telescope.defaults.extensions.frecency = {
--   db_root = join_paths(vim.fn.stdpath("data"), "file_frecency.sqlite3"),
--   show_scores = false,
--   show_unindexed = true,
--   ignore_patterns = { "*.git/*", "*/tmp/*" },
--   disable_devicons = false,
--   workspaces = {
--     ["config"] = join_paths(os.getenv "HOME", ".config"),
--     ["data"] = join_paths(os.getenv "HOME", ".local", "share"),
--     ["projects"] = join_paths(os.getenv "HOME", "Documents"),
--   },
-- }

-- lvim.builtin.telescope.defaults.extensions.hop = {
--   -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
--   keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }, -- ... and more
--   -- Highlight groups to link to signs and lines; the below configuration refers to demo
--   -- sign_hl typically only defines foreground to possibly be combined with line_hl
--   sign_hl = { "WarningMsg", "Title" },
--   -- optional, typically a table of two highlight groups that are alternated between
--   line_hl = { "CursorLine", "Normal" },
--   -- options specific to `hop_loop`
--   -- true temporarily disables Telescope selection highlighting
--   clear_selection_hl = false,
--   -- highlight hopped to entry with telescope selection highlight
--   -- note: mutually exclusive with `clear_selection_hl`
--   trace_entry = true,
--   -- jump to entry where hoop loop was started from
--   reset_selection = true,
-- }

lvim.builtin.telescope.defaults.extensions["ui-select"] = {
  require("telescope.themes").get_dropdown {
    -- even more opts
  },
}

lvim.builtin.telescope.defaults.extensions.arecibo = {
  ["selected_engine"]   = 'google',
  ["url_open_command"]  = 'xdg-open',
  ["show_http_headers"] = false,
  ["show_domain_icons"] = false,
}

for _, extension in ipairs({
    -- "projects",
    "fzf",
    "file_browser",
    -- "media_files",
    "packer",
    "frecency",
    "smart_history",
    -- "arecibo",
    -- "cheat",
    "gh"
}) do
  pcall(function() require("telescope").load_extension(extension) end)
end

-- pcall(function()
--   require("telescope").load_extension("projects")
-- end)
-- pcall(function()
--   require("telescope").load_extension("fzf")
-- end)
-- pcall(function()
--   require("telescope").load_extension("file_browser")
-- end)
-- pcall(function()
--   require("telescope").load_extension("media_files")
-- end)
-- pcall(function()
--   require("telescope").load_extension("packer")
-- end)
-- pcall(function()
--   require("telescope").load_extension("fzy_native")
-- end)
-- pcall(function()
--   require("telescope").load_extension("frecency")
-- end)
-- pcall(function()
--   require("telescope").load_extension("smart_history")
-- end)
-- pcall(function()
--   require("telescope").load_extension("arecibo")
-- end)
-- pcall(function()
--   require("telescope").load_extension("cheat")
-- end)
-- pcall(function()
--   require("telescope").load_extension("gh")
-- end)
