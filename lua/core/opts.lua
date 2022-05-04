local vim = vim
local lvim = lvim
local g, opt = vim.g, vim.opt
local join_paths = join_paths

g.do_filetype_lua = 1
opt.cmdheight = 1
lvim.log.level = "error"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- lvim.transparent_window = true
lvim.use_icons = true
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.bufferline.active = false
lvim.builtin.which_key.setup.window.border = "none"
-- vim.pretty_print(lvim.builtin)


g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
-- getscript
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
-- matchit
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
--- netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
-- dont use python2
g.loaded_python_provider = 0
g.python_host_prog = "/bin/python2"
g.python3_host_prog = "/bin/python"
g.node_host_prog = "/bin/neovim-node-host"

opt.hlsearch = true -- highlight all matches on previous search pattern
-- opt.iskeyword = "@,48-57,_,192-255" -- Keywords are used in searching and recognizing with many commands: "w", "*", "[i", etc.
opt.iskeyword = { "@", "48-57", "_", "192-255" }
opt.showmatch = true -- jump to correspond brace for matchtime
opt.matchtime = 2 -- default 5
opt.autochdir = true -- When on, Vim will change the current working directory whenever you open a file, switch buffers, delete a buffer or open/close a window.
opt.mouse = "nivc"
-- Mouse support can be enabled for different modes:
--  n       Normal mode
--  v       Visual mode
--  i       Insert mode
--  c       Command-line mode
--  h       all previous modes when editing a help file
--  a       all previous modes
--  r       for |hit-enter| and |more-prompt| prompt
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.smarttab = true -- When on, a <Tab> in front of a line inserts blanks according to "shiftwidth".
opt.shiftround = true -- Round indent to multiple of "shiftwidth".
opt.textwidth = 100 -- Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width.
opt.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
opt.autoindent = true -- Copy indent from current line when starting a new line (typing <CR> in Insert mode or when using the "o" or "O" command).
opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
opt.shiftwidth = 2 --  Returns the effective value of "shiftwidth". This is the "shiftwidth" value unless it is zero
opt.softtabstop = -1 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
opt.timeout = true -- This option and "timeoutlen" determine the behavior when part of a mapped key sequence has been received.
opt.ttimeout = true
opt.timeoutlen = 500 -- time in ms to wait for mapped sequence to complete
opt.ttimeoutlen = 10 -- time in ms to wait for a key code sequence to complete
opt.updatetime = 100 -- if in this ms nothing writtin swap is written to disk
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case
opt.infercase = true -- When doing keyword completion in insert mode |ins-completion|, and "ignorecase" is also on, the case of the match is adjusted depending on the typed text.
opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
opt.wrapscan = true -- Searches wrap around the end of the file.
opt.splitbelow = true -- When on, splitting a window will put the new window below the current one.
opt.splitright = true -- When on, splitting a window will put the new window right of the current one.
opt.inccommand = "split" -- nosplit Shows the effects of a command incrementally in the buffer.
-- Like "nosplit", but also shows partial off-screen results in a preview window.
opt.joinspaces = false -- dont add spaces to end of lines
opt.completeopt = { "menu", "menuone", "noselect" } -- A comma-separated list of options for Insert mode completion |ins-completion|.  The supported values are:

-- Allow specified keys that move the cursor left/right to move to the previous/next
-- opt.whichwrap:append("h") -- not recommended
-- opt.whichwrap:append("l") -- not recommended
opt.whichwrap:append("<")
opt.whichwrap:append(">")
opt.whichwrap:append("[")
opt.whichwrap:append("]")
opt.whichwrap:append("~")
-- opt.shortmess:append "I" -- don't show the default intro message
opt.shortmess:remove("I") -- don't show the default intro message
opt.shortmess:remove("c") -- don't show redundant messages from ins-completion-menu
opt.formatoptions:append("j") -- join comments when it makes sense
opt.formatoptions:append("c") -- Auto-wrap comments using textwidth, inserting the current comment leader automatically.
opt.formatoptions:append("r") -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
opt.formatoptions:append("o") -- Automatically insert the current comment leader after hitting "o" or "O" in Normal mode.
opt.formatoptions:append("q") -- Allow formatting of comments with "gq".

local exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

--- Check if a directory exists in this path
local isdir = function(path)
  -- "/" works on both Unix and Windows
  return exists(path .. "/")
end

local cache_path = vim.fn.stdpath("cache") .. "/lvim"
local data_path = {
  join_paths(cache_path .. "/backup"),
  join_paths(cache_path .. "/session"),
  join_paths(cache_path .. "/swap"),
  join_paths(cache_path .. "/tags"),
  join_paths(cache_path .. "/undo"),
}

if not exists(cache_path) then
  os.execute("mkdir -p " .. cache_path)
end
for _, v in pairs(data_path) do
  if isdir(v) then
    os.execute("mkdir -p " .. v)
  end
end
-- ctrl space
opt.encoding = "utf-8"

opt.directory = join_paths(cache_path .. "/swag")
opt.undodir = join_paths(cache_path .. "/undo")
opt.backupdir = join_paths(cache_path .. "/backup")
opt.viewdir = join_paths(cache_path .. "/view")
-- opt.spellfile = join_paths(cache_path .. "/spell/en.uft-8.add")
opt.shadafile = join_paths(cache_path .. "/shada")
opt.shada = [[!,'300,<50,@100,s10,h]]
opt.filetype = "plugin"
opt.fsync = true
opt.backup = false -- creates a backup file
opt.writebackup = false
opt.undofile = true
opt.swapfile = false -- Use a swapfile for the buffer.
opt.history = 2000 -- The command-lines that you enter are remembered in a history table.
opt.autoread = true -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
opt.backupskip = { "/tmp/*", "$TMPDIR/*", "$TMP/*", "$TEMP/*", "*/shm/*", "/private/var/*", ".vault.vim" }

opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.background = "dark"
opt.guifont = "Victor Mono Nerd Font:h12"
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.termguicolors = true
opt.errorbells = false -- Ring the bell (beep or screen flash) for error messages.
opt.visualbell = false -- Use visual bell instead of beeping.
opt.lazyredraw = true -- Redraw only when needed.
opt.redrawtime = 1500
opt.signcolumn = "number" -- "yes:1"
-- opt.showtabline = 1 -- always show tabs 2 always, 1 more then 1 tab, 0 never
opt.winwidth = 30
opt.winminwidth = 10
opt.pumheight = 15 -- pop up menu height
opt.helpheight = 12
opt.previewheight = 12
opt.showcmd = true -- Show (partial) command in the last line of the screen.
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.cmdwinheight = 5 -- Number of screen lines to use for the command-line window.
opt.equalalways = false -- When on, all the windows are automatically made the same size after splitting or closing a window.
opt.laststatus = 3 -- The value of this option influences when the last window will have a status linealways and ONLY the last window
opt.display = "lastline"
opt.cursorline = true --  Highlight the text line of the cursor with CursorLine |hl-CursorLine|.
opt.cursorlineopt = "number" -- (line,screenline,number, both - line/number ) Highlight the text line of the cursor with CursorLine |hl-CursorLine|.
-- opt.pumblend = 0
-- opt.winblend = 0
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.number = true
-- opt.relativenumber = true,
opt.showmode = false -- shows modes like -- INSERT --
opt.scrolloff = 2
opt.sidescrolloff = 5





-- opt.syntax = "enable" -- Syntax highlighting enables Vim to show parts of the text in another font or color.
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
-- opt.fileformats = { "unix", "mac", "dos" }
opt.magic = true -- Some characters in the pattern, such as letters, are taken literally.
opt.virtualedit = "block" -- Allow virtual editing in Visual block mode.
opt.viewoptions = { "folds", "cursor", "curdir" }
opt.sessionoptions = { "curdir", "help", "tabpages", "winsize" } -- Changes the effect of the |:mksession| command.
opt.wildignorecase = true -- When set case is ignored when completing file names and directories.
opt.wildignore = { -- A file that matches with one of these patterns is ignored when expanding |wildcards|
  "*.pyc",
  "*.o",
  "*.out",
  "*.jpg",
  "*.jpeg",
  "*.png",
  "*.gif",
  "*.zip",
  "**/tmp/**",
  "*.DS_Store",
  "**/node_modules/**",
  "**/bower_modules/**",
}
opt.complete = { ".", "w", "b", "k" } -- set the matches for Insert mode completion.
opt.grepformat = "%f:%l:%c:%m" -- Format to recognize for the ":grep" command output.
opt.grepprg = "rg --hidden --vimgrep --smart-case --" -- Program to use for the |:grep| command.
opt.startofline = false -- When "on" the commands listed below move the cursor to the first non-blank of the line.
opt.switchbuf = "useopen" -- This option controls the behavior when switching between buffers.
opt.backspace = { "indent", "eol", "start" }
opt.diffopt = { "filler", "iwhite", "internal", "algorithm:patience" } -- Option settings for diff mode.
opt.completeopt = { "menuone", "noselect" }
opt.jumpoptions = "stack" -- List of words that change the behavior of the |jumplist|.
opt.foldlevelstart = 99 -- Sets "foldlevel" when starting to edit another buffer in a window.
opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
opt.ruler = true --  Show the line and column number of the cursor position, separated by a comma.
opt.wrap = false -- When on, lines longer than the width of the window will wrap and displaying continues on the next line.
opt.synmaxcol = 500 -- Maximum column in which to search for syntax items.
opt.linebreak = false -- indext the linenumber (I hate this...) -- If on, Vim will wrap long lines at a character in "breakat" rather than at the last character that fits on the screen.
opt.breakat = [[\ \ ;:,!?]] -- his option lets you choose which characters might cause a line break if "linebreak" is on.
opt.breakindentopt = { -- Settings for "breakindent".
  shift = 2,
  min = 20,
}
opt.foldenable = false -- When off, all folds are open.
opt.conceallevel = 2 -- set to 0 if `` is visible in markdown files
opt.concealcursor = "niv" -- Sets the modes in which text in the cursor line can also be concealed. When the current mode is listed then concealing happens just like in other lines.

opt.list = true
opt.listchars = {
  -- eol = "↲",
  tab = "⎵/",
  nbsp = "+",
  trail = "·",
  extends = "→",
  precedes = "←",
}
opt.fillchars = {
  --    item            default         Used for ~
  stl = " ", -- " " or "^" statusline of the current window
  stlnc = " ", -- " " or "=" statusline of the non-current windows
  horiz = "─", -- "─" or "-" horizontal separators |:split|
  horizup = "┴", -- "┴" or "-" upwards facing horizontal separator
  horizdown = "┬", -- "┬" or "-" downwards facing horizontal separator
  vert = "│", -- "│" or "|" vertical separators |:vsplit|
  vertleft = "┤", -- "┤" or "|" left facing vertical separator
  vertright = "├", -- "├" or "|" right facing vertical separator
  verthoriz = "┼", -- "┼" or "+" overlapping vertical and horizontal separator
  fold = "-", -- "·" or "-" filling "foldtext"
  foldopen = "-", -- "-" mark the beginning of a fold
  foldclose = "+", -- "+" show a closed fold
  foldsep = "│", -- "│" or "|" open fold middle marker
  diff = "-", -- "-" deleted lines of the "diff" option
  msgsep = " ", -- " " message separator "display"
  eob = " ", -- "~" empty lines at the end of a buffer
}
