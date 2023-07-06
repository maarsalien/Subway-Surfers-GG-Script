local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.Meta.UpgradesModel",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    GetPowerupLevel = {
      name = "GetPowerupLevel",
      offset = 0x9C01F4,
    },
  },
})
