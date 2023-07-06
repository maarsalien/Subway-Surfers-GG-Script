local mem = require("libs.memory")

local function load(libname)
  local lib = mem.findModuleExportByName(libname)
  if not lib then
    error("Unable to find library: " .. libname)
  end
  return lib
end

return {
  libil2cpp = load "libil2cpp.so",
}
