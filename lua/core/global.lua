local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  Reloader = require
else
  Reloader = plenary_reload.reload_module
end

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return Reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
