local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.Meta.Achievement",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    get_IsTierCompleted = {
      name = "get_IsTierCompleted",
      offset = 0x8F5768,
    },
  },
})
