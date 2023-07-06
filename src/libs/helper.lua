local f = string.format

local hlp = {}

function hlp.printf(...)
  print(f(...))
end

function hlp.isFunction(val)
  return type(val) == "function"
end

function hlp.isString(val)
  return type(val) == "string"
end

function hlp.isModuleName(str)
  return
      hlp.isString(str)
      and #str > 0
      and str:find("^lib.*%.so$")
      and true or false
end

return hlp
