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
vim.api.nvim_set_var("mapleader", t"<space>")
lvim.leader = "space"
lvim.builtin.which_key.mappings = {}
lvim.keys = {
  ---@usage change or add keymappings for insert mode
  insert_mode = {
    -- 'jk' for quitting insert mode
    ["jk"] = "<ESC>",
    -- 'kj' for quitting insert mode
    ["kj"] = "<ESC>",
    -- 'jj' for quitting insert mode
    ["jj"] = "<ESC>",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },

  ---@usage change or add keymappings for normal mode
  normal_mode = {
    -- Better window movement
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":BufferLineCycleNext<CR>",
    ["<S-h>"] = ":BufferLineCyclePrev<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- ["p"] = '"0p',
    -- ["P"] = '"0P',
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },

  ---@usage change or add keymappings for command mode
  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

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
legendary.bind_keymaps({
  { "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", opts = { noremap = false, nowait = true }, mode = {"c"} },
})

TelescopeMapArgs = TelescopeMapArgs or {}
local telecmd = function(key, fn, options)
  TelescopeMapArgs[t(key .. fn)] = options or {}
  return ([[:lua R("modules.telescope")["%s"](TelescopeMapArgs["%s"])<CR>]]):format(fn, t(key .. fn))
end

local peek = require('lvim.lsp.peek')
local lvim_custom_finders = require("lvim.core.telescope.custom-finders")
local lvim_core_term = require("lvim.core.terminal")

local opts = { noremap = true, silent = true }
M.leadermaps = {
  { "<C-e>", ":Telescope file_browser path=%:p:h<CR>", description = "Telescope File Explorer" },
  { "<ESC>", "<ESC>:noh<CR>", description = "No highlight on <esc> in normal", mode = { "n" }, opts = opts },
  { "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)",
    opts = { noremap = false, nowait = true }, mode = {"c"},
    description = "Telescope Fuzzy Command Search"
  },
  { "<leader>w", ":w!<CR>", description = "Save" },
  { "<leader>q", ":q!<CR>", description = "Quit" },
  { "<leader>j", ":HopWord<CR>", "Jump!" },
  { "<leader>/", [[:lua require("Comment.api").toggle_current_linewise()<CR>]], description = "Comment" },
  { "<leader>c", ":BufferKill<CR>", description = "Close Buffer" },
  { "<leader>e", ":NvimTreeToggle<CR>", description = "NvimTree File Explorer" },
  { "<leader>f", lvim_custom_finders.find_project_files, description = "Find File" },
  { "<leader>h", ":nohlsearch<CR>", description = "No Highlight" },
  { "<leader>\\", ":vnew<CR>", description = "Vertical Split" },
  { "<leader>-", ":new<CR>", description = "Horizontal Split" },
  { "<leader>s", description = "Search" },
  { "<leader>sN", telecmd("N", "edit_neovim", {}), description = "Edit NeoVim" },
  { "<leader>sZ", telecmd("Z", "edit_zsh", {}), description = "Edit ZSH" },
  { "<leader>sF", telecmd("F", "edit_fish", {}), description = "Edit Fish" },
  { "<leader>sg", telecmd("g", "git_branches", {}), description = "Git Branches" },
  { "<leader>sc", telecmd("c", "colorscheme", {}), description = "Colorscheme" },
  { "<leader>sf", telecmd("f", "find_files", {}), description = "Find File" },
  { "<leader>sh", telecmd("h", "help_tags", {}), description = "Find Help" },
  { "<leader>sM", telecmd("M", "man_pages", {}), description = "Manpages" },
  { "<leader>sr", telecmd("r", "oldfiles", {}), description = "Open Recent File" },
  { "<leader>sR", telecmd("R", "registers", {}), description = "Registers" },
  { "<leader>st", telecmd("t", "live_grep", {}), description = "Text" },
  { "<leader>sb", telecmd("b", "buffers", {}), "Buffers" },
  { "<leader>sk", ":Legendary keymaps<CR>", description = "Keymaps" },
  { "<leader>sC", ":Legendary commands<CR>", description = "Commands" },
  { "<leader>sa", ":Legendary autocmds<CR>", description = "Autocmds" },
  { "<leader>p", description = "Packer" },
  { "<leader>pc", ":PackerCompile<CR>", description = "Compile" },
  { "<leader>pi", ":PackerInstall<CR>", description = "Install" },
  { "<leader>pr", require("lvim.plugin-loader").recompile, description = "Re-compile" },
  { "<leader>ps", ":PackerSync<CR>", description = "Sync" },
  { "<leader>pS", ":PackerStatus<CR>", description = "Status" },
  { "<leader>pu", ":PackerUpdate<CR>", description = "Update" },
  { "<leader>g", description = "Git" },
  { "<leader>gj", [[:lua require("gitsigns").next_hunk()<CR>]], description = "Next Hunk" },
  { "<leader>gk", [[:lua require("gitsigns").prev_hunk()<CR>]], description = "Prev Hunk" },
  { "<leader>gl", [[:lua require("gitsigns").blame_line()<CR>]], description = "Blame" },
  { "<leader>gp", [[:lua require("gitsigns").preview_hunk()<CR>]], description = "Preview Hunk" },
  { "<leader>gr", [[:lua require("gitsigns").reset_hunk()<CR>]], description = "Reset Hunk" },
  { "<leader>gR", [[:lua require("gitsigns").reset_buffer()<CR>]], description = "Reset Buffer" },
  { "<leader>gs", [[:lua require("gitsigns").stage_hunk()<CR>]], description = "Stage Hunk" },
  { "<leader>gu", [[:lua require("gitsigns").undo_stage_hunk()<CR>]], description = "Undo Stage Hunk" },
  { "<leader>go", ":Telescope git_status<CR>", description = "Open changed file" },
  { "<leader>gb", ":Telescope git_branches<CR>", description = "Checkout branch" },
  { "<leader>gc", ":Telescope git_commits<CR>", description = "Checkout commit" },
  { "<leader>gC", ":Telescope git_bcommits<CR>", description = "Checkout commit(for current file)" },
  { "<leader>gd", ":Gitsigns diffthis HEAD<CR>", description = "Git Diff" },
  { "<leader>l", description = "LSP" },
  { "<leader>la", require("lvim.core.telescope").code_actions, description = "Code Action" },
  { "<leader>ld", ":Telescope diagnostics bufnr=0 theme=get_ivy<CR>", description = "Buffer Diagnostics" },
  { "<leader>lw", ":Telescope diagnostics<CR>", description = "Diagnostics" },
  { "<leader>lf", vim.lsp.buf.formatting, description = "Format" },
  { "<leader>li", ":LspInfo<CR>", description = "Info" },
  { "<leader>lI", ":LspInstallInfo<CR>", "Installer Info" },
  { "<leader>lj", vim.diagnostic.goto_next, description = "Next Diagnostic" },
  { "<leader>lk", vim.diagnostic.goto_prev,description =  "Prev Diagnostic" },
  { "<leader>ll", vim.lsp.codelens.run, description = "CodeLens Action" },
  { "<leader>lp", description = "Peek" },
  { "<leader>lpd", function() peek.Peek("definition") end, description = "Definition" },
  { "<leader>lpt", function() peek.Peek("typeDefinition") end, description = "Definition" },
  { "<leader>lpi", function() peek.Peek("implementation") end, description = "Definition" },
  { "<leader>lq", vim.diagnostic.setloclist, description = "Quickfix" },
  { "<leader>lr", vim.lsp.buf.rename, description = "Rename" },
  { "<leader>ls", ":Telescope lsp_document_symbols<CR>", description = "Document Symbols" },
  { "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<CR>", description = "Workspace Symbols" },
  { "<leader>le", ":Telescope quickfix<CR>", description = "Telescope Quickfix" },
  { "<leader>T", description = "Treesitter" },
  { "<leader>Ti", ":TSConfigInfo<CR>", description = "Info" },
  { "<leader>L", description = "LunarVim" },
  { "<leader>Lc", ":edit /home/draxel/.config/lvim/config.lua<CR>", description = "Edit config.lua" },
  { "<leader>Lf", lvim_custom_finders.find_lunarvim_files, description = "Find LunarVim files" },
  { "<leader>Lg", lvim_custom_finders.grep_lunarvim_files, description = "Grep LunarVim files" },
  { "<leader>Li", function() require("lvim.core.info").toggle_popup(vim.bo.filetype) end, description = "Toggle LunarVim Info" },
  { "<leader>Ll", description = "Logs" },
  { "<leader>LlI", lvim_custom_finders.view_lunarvim_changelog, description = "View LunarVim's changelog",},
  { "<leader>Lld", function() lvim_core_term.toggle_log_view(require("lvim.core.log").get_path())end , description = "view default log" },
  { "<leader>LlD", [[:lua vim.fn.execute("edit " .. require("lvim.core.log").get_path())]], description = "Open the default logfile" },
  { "<leader>Lll", function() lvim_core_term.toggle_log_view(vim.lsp.get_log_path()) end, description = "view lsp log" },
  { "<leader>LlL", function() vim.fn.execute("edit "..vim.lsp.get_log_path()) end, description = "Open the LSP logfile" },
  { "<leader>Lln", function() lvim_core_term.toggle_log_view(os.getenv("NVIM_LOG_FILE")) end, description = "view neovim log"},
  { "<leader>LlN", ":edit $NVIM_LOG_FILE<CR>", "Open the Neovim logfile" },
  { "<leader>Llp", function() lvim_core_term.toggle_log_view("packer.nvim") end, description = "view packer log" },
  { "<leader>LlP", ":exe 'edit '.stdpath('cache').'/packer.nvim.log'<CR>", description = "Open the Packer logfile" },
  { "<leader>Lr", ":LvimReload<CR>", description = "Reload LunarVim's configuration" },
  { "<leader>Lu", ":LvimUpdate<CR>", description = "Update LunarVim" },
  { "<leader>h", description = "Help" },
  { "<leader>hc", ":Cheatsheet<CR>", description = "Open cheatsheet" },
  { "<leader>he", ":CheatsheetEdit<CR>", description = "Edit cheatsheet" },

}

for _, m in ipairs(M.leadermaps) do
  local opts = vim.tbl_deep_extend("force", wkopts, m.opts or {})
  m.mode = m.mode or {"n"}
  if type(m.mode) == "string" then
    m.mode = {m.mode}
  end
  for _, mode in ipairs(m.mode) do
    opts.mode = mode
    wk.register({ [m[1]] = m.description }, opts)
  end
end
legendary.bind_keymaps(M.leadermaps)

return M
