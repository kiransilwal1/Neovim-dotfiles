-- Define global helper functions
_G.P = function(v)
  print(vim.inspect(v))
  return v
end

_G.RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

_G.R = function(name)
  RELOAD(name)
  return require(name)
end

function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end
