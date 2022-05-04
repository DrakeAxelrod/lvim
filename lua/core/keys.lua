local lvim = lvim
local vim = vim
local M = {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local wk = require("which-key")
local wkopts = {
  mode = "n", -- NORMAL mode
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local legendary = require("legendary")
vim.api.nvim_set_var("mapleader", t("<space>"))
lvim.leader = "space"
lvim.builtin.which_key.mappings = {}

-- unbind all the lvim keybinds
-- lvim.keys.insert_mode["jk"] = false
-- lvim.keys.insert_mode["kj"] = false
-- lvim.keys.insert_mode["jj"] = false
-- lvim.keys.insert_mode["<A-j>"] = false
-- lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.insert_mode["<A-Up>"] = false
lvim.keys.insert_mode["<A-Down>"] = false
lvim.keys.insert_mode["<A-Left>"] = false
lvim.keys.insert_mode["<A-Right>"] = false
-- lvim.keys.normal_mode["<C-h>"] = false
-- lvim.keys.normal_mode["<C-j>"] = false
-- lvim.keys.normal_mode["<C-k>"] = false
-- lvim.keys.normal_mode["<C-l>"] = false
lvim.keys.normal_mode["<C-Up>"] = false
lvim.keys.normal_mode["<C-Down>"] = false
lvim.keys.normal_mode["<C-Left>"] = false
lvim.keys.normal_mode["<C-Right>"] = false
lvim.keys.normal_mode["<S-l>"] = ":CmdResizeRight<CR>"
lvim.keys.normal_mode["<S-h>"] = ":CmdResizeLeft<CR>"
-- lvim.keys.normal_mode["<A-j>"] = false
-- lvim.keys.normal_mode["<A-k>"] = false
-- lvim.keys.normal_mode["]q"] = false
-- lvim.keys.normal_mode["[q"] = false
lvim.keys.normal_mode["<C-q>"] = false
-- lvim.keys.term_mode["<C-h>"] = false
-- lvim.keys.term_mode["<C-j>"] = false
-- lvim.keys.term_mode["<C-k>"] = false
-- lvim.keys.term_mode["<C-l>"] = false
-- lvim.keys.visual_mode["<"] = false
-- lvim.keys.visual_mode[">"] = false
lvim.keys.visual_block_mode["K"] = false
lvim.keys.visual_block_mode["J"] = false
-- lvim.keys.visual_block_mode["<A-j>"] = false
-- lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.command_mode["<C-j>"] = false
lvim.keys.command_mode["<C-k>"] = false

--   -- 'jk' for quitting insert mode
--   ["jk"] = "<ESC>",
--   -- 'kj' for quitting insert mode
--   ["kj"] = "<ESC>",
--   -- 'jj' for quitting insert mode
--   ["jj"] = "<ESC>",
--   -- Move current line / block with Alt-j/k ala vscode.
--   ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
--   -- Move current line / block with Alt-j/k ala vscode.
--   ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
--   -- navigation
--   ["<A-Up>"] = "<C-\\><C-N><C-w>k",
--   ["<A-Down>"] = "<C-\\><C-N><C-w>j",
--   ["<A-Left>"] = "<C-\\><C-N><C-w>h",
--   ["<A-Right>"] = "<C-\\><C-N><C-w>l",
-- }
--   -- Better window movement
--   ["<C-h>"] = "<C-w>h",
--   ["<C-j>"] = "<C-w>j",
--   ["<C-k>"] = "<C-w>k",
--   ["<C-l>"] = "<C-w>l",
--   -- Resize with arrows
--   ["<C-Up>"] = ":resize -2<CR>",
--   ["<C-Down>"] = ":resize +2<CR>",
--   ["<C-Left>"] = ":vertical resize -2<CR>",
--   ["<C-Right>"] = ":vertical resize +2<CR>",
--   -- Tab switch buffer
--   ["<S-l>"] = ":BufferLineCycleNext<CR>",
--   ["<S-h>"] = ":BufferLineCyclePrev<CR>",
--   -- Move current line / block with Alt-j/k a la vscode.
--   ["<A-j>"] = ":m .+1<CR>==",
--   ["<A-k>"] = ":m .-2<CR>==",
--   -- QuickFix
--   ["]q"] = ":cnext<CR>",
--   ["[q"] = ":cprev<CR>",
--   ["<C-q>"] = ":call QuickFixToggle()<CR>",
--   -- Splits
--   -- fuck off heightlighting
--   ["<ESC>"] = "<ESC>:noh<CR>",
--   ["<C-e>"] = ":Telescope file_browser<CR>",
-- }

--   ["<C-h>"] = "<C-\\><C-N><C-w>h",
--   ["<C-j>"] = "<C-\\><C-N><C-w>j",
--   ["<C-k>"] = "<C-\\><C-N><C-w>k",
--   ["<C-l>"] = "<C-\\><C-N><C-w>l",
-- }

--   ["<"] = "<gv",
--   [">"] = ">gv",
--   ["/"] = { "<ESC>:lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
--   -- ["p"] = '"0p',
--   -- ["P"] = '"0P',
-- }
-- {
--   -- Move selected line / block of text in visual mode
--   ["K"] = ":move '<-2<CR>gv-gv",
--   ["J"] = ":move '>+1<CR>gv-gv",
--   -- Move current line / block with Alt-j/k ala vscode.
--   ["<A-j>"] = ":m '>+1<CR>gv-gv",
--   ["<A-k>"] = ":m '<-2<CR>gv-gv",
-- }
--   -- search commands with telescope
--   ["<C-r><C-r>"] = { "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true } },
--   -- -- navigate tab completion with <c-j> and <c-k>
--   -- -- runs conditionally
--   ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
--   ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
-- }
TelescopeMapArgs = TelescopeMapArgs or {}
local telecmd = function(key, fn, options)
  TelescopeMapArgs[t(key .. fn)] = options or {}
  return ([[:lua R("modules.telescope")["%s"](TelescopeMapArgs["%s"])<CR>]]):format(fn, t(key .. fn))
end

local peek = require("lvim.lsp.peek")
local lvim_custom_finders = require("lvim.core.telescope.custom-finders")
local lvim_core_term = require("lvim.core.terminal")

local opts = { noremap = true, silent = true }
M.leadermaps = {
  { "<C-e>", ":Telescope file_browser path=%:p:h<CR>", description = "File Explorer", opts = opts },
  { "<ESC>", "<ESC>:noh<CR>", description = "No highlight on <esc> in normal", mode = { "n" }, opts = opts },
  {
    "<C-r><C-r>",
    "<Plug>(TelescopeFuzzyCommandSearch)",
    opts = { noremap = false, nowait = true },
    mode = { "c" },
    description = "Telescope Fuzzy Command Search",
  },
  { "<C-h>", "<C-w>h", description = "Move cursor left buffer", mode = { "n" }, opts = opts },
  { "<C-j>", "<C-w>j", description = "Move cursor below buffer", mode = { "n" }, opts = opts },
  { "<C-k>", "<C-w>k", description = "Move cursor above buffer", mode = { "n" }, opts = opts },
  { "<C-l>", "<C-w>l", description = "Move cursor right buffer", mode = { "n" }, opts = opts },
  { "<S-h>", ":CmdResizeLeft<CR>", description = "Resize buffer toward left", mode = { "n" } },
  { "<S-j>", ":CmdResizeDown<CR>", description = "Resize buffer toward below", mode = { "n" } },
  { "<S-k>", ":CmdResizeUp<CR>", description = "Resize buffer towards above", mode = { "n" } },
  { "<S-l>", ":CmdResizeRight<CR>", description = "Resize buffer toward right", mode = { "n" }, opts = opts },
  -- terminal mode
  { "<ESC>", [[<C-\\><C-n>]], description = "<esc> to normal mode in terminal mode", mode = { "t" } },
  { "<C-h>", [[<C-\\><C-n><C-W>h]], description = "Move cursor left buffer", mode = { "t" } },
  { "<C-j>", [[<C-\\><C-n><C-W>j]], description = "Move cursor left buffer", mode = { "t" } },
  { "<C-k>", [[<C-\\><C-n><C-W>k]], description = "Move cursor left buffer", mode = { "t" } },
  { "<C-l>", [[<C-\\><C-n><C-W>l]], description = "Move cursor left buffer", mode = { "t" } },
  -- Leader mappings start
  { "<leader>?", description = "Cheatsheet" },
  { "<leader>w", ":w!<CR>", description = "Save", opts = opts },
  { "<leader>q", ":q!<CR>", description = "Quit", opts = opts },
  { "<leader>j", ":HopWord<CR>", description = "Jump!", opts = opts },
  {
    "<leader>/",
    [[:lua require("Comment.api").toggle_current_linewise()<CR>]],
    description = "Comment",
    opts = opts,
  },
  { "<leader>c", ":BufferKill<CR>", description = "Close Buffer", opts = opts },
  -- { "<leader>e", ":NvimTreeToggle<CR>", description = "NvimTree File Explorer", opts = opts },
  { "<leader>e", ":Telescope file_browser path=%:p:h<CR>", description = "File Explorer", opts = opts },
  { "<leader>f", lvim_custom_finders.find_project_files, description = "Find File", opts = opts },
  -- { "<leader>h", ":nohlsearch<CR>", description = "No Highlight", opts = opts },
  { "<leader>\\", ":vnew<CR>", description = "Vertical Split", opts = opts },
  { "<leader>-", ":new<CR>", description = "Horizontal Split", opts = opts },
  { "<leader>s", description = "+Search" },
  { "<leader>sN", telecmd("N", "edit_neovim", {}), description = "Edit NeoVim", opts = opts },
  { "<leader>sZ", telecmd("Z", "edit_zsh", {}), description = "Edit ZSH", opts = opts },
  { "<leader>sF", telecmd("F", "edit_fish", {}), description = "Edit Fish", opts = opts },
  { "<leader>sg", telecmd("g", "git_branches", {}), description = "Git Branches", opts = opts },
  { "<leader>sc", telecmd("c", "colorscheme", {}), description = "Colorscheme", opts = opts },
  { "<leader>sf", telecmd("f", "find_files", {}), description = "Find File", opts = opts },
  { "<leader>sh", telecmd("h", "help_tags", {}), description = "Find Help", opts = opts },
  { "<leader>sM", telecmd("M", "man_pages", {}), description = "Manpages", opts = opts },
  { "<leader>sr", telecmd("r", "oldfiles", {}), description = "Open Recent File", opts = opts },
  { "<leader>sR", telecmd("R", "registers", {}), description = "Registers", opts = opts },
  { "<leader>st", telecmd("t", "live_grep", {}), description = "Text", opts = opts },
  { "<leader>sb", telecmd("b", "buffers", {}), description = "Buffers", opts = opts },
  { "<leader>sk", ":Legendary keymaps<CR>", description = "Keymaps", opts = opts },
  { "<leader>sC", ":Legendary commands<CR>", description = "Commands", opts = opts },
  { "<leader>sa", ":Legendary autocmds<CR>", description = "Autocmds", opts = opts },
  { "<leader>p", description = "+Packer" },
  { "<leader>pc", ":PackerCompile<CR>", description = "Compile", opts = opts },
  { "<leader>pi", ":PackerInstall<CR>", description = "Install", opts = opts },
  { "<leader>pr", require("lvim.plugin-loader").recompile, description = "Re-compile", opts = opts },
  { "<leader>ps", ":PackerSync<CR>", description = "Sync", opts = opts },
  { "<leader>pS", ":PackerStatus<CR>", description = "Status", opts = opts },
  { "<leader>pu", ":PackerUpdate<CR>", description = "Update", opts = opts },
  { "<leader>g", description = "+Git" },
  { "<leader>gj", [[:lua require("gitsigns").next_hunk()<CR>]], description = "Next Hunk", opts = opts },
  { "<leader>gk", [[:lua require("gitsigns").prev_hunk()<CR>]], description = "Prev Hunk", opts = opts },
  { "<leader>gl", [[:lua require("gitsigns").blame_line()<CR>]], description = "Blame", opts = opts },
  { "<leader>gp", [[:lua require("gitsigns").preview_hunk()<CR>]], description = "Preview Hunk", opts = opts },
  { "<leader>gr", [[:lua require("gitsigns").reset_hunk()<CR>]], description = "Reset Hunk", opts = opts },
  { "<leader>gR", [[:lua require("gitsigns").reset_buffer()<CR>]], description = "Reset Buffer", opts = opts },
  { "<leader>gs", [[:lua require("gitsigns").stage_hunk()<CR>]], description = "Stage Hunk", opts = opts },
  { "<leader>gu", [[:lua require("gitsigns").undo_stage_hunk()<CR>]], description = "Undo Stage Hunk", opts = opts },
  { "<leader>go", ":Telescope git_status<CR>", description = "Open changed file", opts = opts },
  { "<leader>gb", ":Telescope git_branches<CR>", description = "Checkout branch", opts = opts },
  { "<leader>gc", ":Telescope git_commits<CR>", description = "Checkout commit", opts = opts },
  { "<leader>gC", ":Telescope git_bcommits<CR>", description = "Checkout commit(for current file)", opts = opts },
  { "<leader>gd", ":Gitsigns diffthis HEAD<CR>", description = "Git Diff", opts = opts },
  { "<leader>l", description = "+LSP" },
  { "<leader>la", require("lvim.core.telescope").code_actions, description = "Code Action", opts = opts },
  {
    "<leader>ld",
    ":Telescope diagnostics bufnr=0 theme=get_ivy<CR>",
    description = "Buffer Diagnostics",
    opts = opts,
  },
  { "<leader>lw", ":Telescope diagnostics<CR>", description = "Diagnostics", opts = opts },
  { "<leader>lf", vim.lsp.buf.formatting, description = "Format", opts = opts },
  { "<leader>li", ":LspInfo<CR>", description = "Info", opts = opts },
  { "<leader>lI", ":LspInstallInfo<CR>", description = "Installer Info", opts = opts },
  { "<leader>lj", vim.diagnostic.goto_next, description = "Next Diagnostic", opts = opts },
  { "<leader>lk", vim.diagnostic.goto_prev, description = "Prev Diagnostic", opts = opts },
  { "<leader>ll", vim.lsp.codelens.run, description = "CodeLens Action", opts = opts },
  { "<leader>lp", description = "Peek", opts = opts },
  {
    "<leader>lpd",
    function()
      peek.Peek("definition")
    end,
    description = "Definition",
    opts = opts,
  },
  {
    "<leader>lpt",
    function()
      peek.Peek("typeDefinition")
    end,
    description = "Definition",
    opts = opts,
  },
  {
    "<leader>lpi",
    function()
      peek.Peek("implementation")
    end,
    description = "Definition",
    opts = opts,
  },
  { "<leader>lq", vim.diagnostic.setloclist, description = "Quickfix", opts = opts },
  { "<leader>lr", vim.lsp.buf.rename, description = "Rename", opts = opts },
  { "<leader>ls", ":Telescope lsp_document_symbols<CR>", description = "Document Symbols", opts = opts },
  { "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<CR>", description = "Workspace Symbols", opts = opts },
  { "<leader>le", ":Telescope quickfix<CR>", description = "Telescope Quickfix", opts = opts },
  { "<leader>T", description = "+Terminal" },
  { "<leader>Th", ":new | :term<CR>i", description = "Horizontal split", opts = opts },
  { "<leader>Tv", ":vnew | :term<CR>i", description = "Vertical split", opts = opts },
  { "<leader>Tt", ":vnew | :term htop<CR>i", description = "Htop", opts = opts },
  { "<leader>Tn", ":vnew | :term node<CR>i", description = "Node", opts = opts },
  { "<leader>Tp", ":vnew | :term python<CR>i", description = "Python", opts = opts },
  { "<leader>Tg", ":vnew | :term lazygit<CR>i", description = "LazyGit", opts = opts },
  { "<leader>L", description = "+LunarVim", opts = opts },
  { "<leader>Lc", ":edit /home/draxel/.config/lvim/config.lua<CR>", description = "Edit config.lua", opts = opts },
  { "<leader>Lf", lvim_custom_finders.find_lunarvim_files, description = "Find LunarVim files", opts = opts },
  { "<leader>Lg", lvim_custom_finders.grep_lunarvim_files, description = "Grep LunarVim files", opts = opts },
  {
    "<leader>Li",
    function()
      require("lvim.core.info").toggle_popup(vim.bo.filetype)
    end,
    description = "Toggle LunarVim Info",
    opts = opts,
  },
  { "<leader>Ll", description = "Logs" },
  {
    "<leader>LlI",
    lvim_custom_finders.view_lunarvim_changelog,
    description = "View LunarVim's changelog",
    opts = opts,
  },
  {
    "<leader>Lld",
    function()
      lvim_core_term.toggle_log_view(require("lvim.core.log").get_path())
    end,
    description = "view default log",
    opts = opts,
  },
  {
    "<leader>LlD",
    [[:lua vim.fn.execute("edit " .. require("lvim.core.log").get_path())]],
    description = "Open the default logfile",
    opts = opts,
  },
  {
    "<leader>Lll",
    function()
      lvim_core_term.toggle_log_view(vim.lsp.get_log_path())
    end,
    description = "view lsp log",
    opts = opts,
  },
  {
    "<leader>LlL",
    function()
      vim.fn.execute("edit " .. vim.lsp.get_log_path())
    end,
    description = "Open the LSP logfile",
    opts = opts,
  },
  {
    "<leader>Lln",
    function()
      lvim_core_term.toggle_log_view(os.getenv("NVIM_LOG_FILE"))
    end,
    description = "view neovim log",
    opts = opts,
  },
  { "<leader>LlN", ":edit $NVIM_LOG_FILE<CR>", description = "Open the Neovim logfile", opts = opts },
  {
    "<leader>Llp",
    function()
      lvim_core_term.toggle_log_view("packer.nvim")
    end,
    description = "view packer log",
    opts = opts,
  },
  {
    "<leader>LlP",
    ":exe 'edit '.stdpath('cache').'/packer.nvim.log'<CR>",
    description = "Open the Packer logfile",
    opts = opts,
  },
  { "<leader>Lr", ":LvimReload<CR>", description = "Reload LunarVim's configuration", opts = opts },
  { "<leader>Lu", ":LvimUpdate<CR>", description = "Update LunarVim", opts = opts },
  -- { "<leader>h", description = "Help" },
  -- { "<leader>hc", ":Cheatsheet<CR>", description = "Open cheatsheet", opts = opts },
  -- { "<leader>he", ":CheatsheetEdit<CR>", description = "Edit cheatsheet", opts = opts },
}

for _, m in ipairs(M.leadermaps) do
  local opts = vim.tbl_deep_extend("force", wkopts, m.opts or {})
  m.mode = m.mode or { "n" }
  if type(m.mode) == "string" then
    m.mode = { m.mode }
  end
  for _, mode in ipairs(m.mode) do
    opts.mode = mode
    wk.register({ [m[1]] = m.description }, opts)
  end
end
legendary.bind_keymaps(M.leadermaps)

return M
