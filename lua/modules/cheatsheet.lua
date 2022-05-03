local ok, cs = pcall(require, "cheatsheet")
if not ok then
  return
end

cs.setup({
  bundled_cheatsheets = true,
  bundled_plugin_cheatsheets = true,
  include_only_installed_plugins = true,
  telescope_mappings = {}
})
