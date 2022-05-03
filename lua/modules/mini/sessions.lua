local ok, session = pcall(require, "mini.sessions")
if not ok then
  return
end
session.setup({
  -- Whether to read latest session if Neovim opened without file arguments
  autoread = false,

  -- Whether to write current session before quitting Neovim
  autowrite = true,

  -- Directory where global sessions are stored (use `""` to disable)
  directory = api.fs.join(vim.fn.stdpath("data").."/session"),--<"session" subdir of user data directory from |stdpath()|>,

  -- File for local session (use `""` to disable)
  file = "Session.vim",

  -- Whether to force possibly harmful actions (meaning depends on function)
  force = { read = false, write = true, delete = false },

  -- Whether to print session path after action
  verbose = { read = false, write = true, delete = true },
})
