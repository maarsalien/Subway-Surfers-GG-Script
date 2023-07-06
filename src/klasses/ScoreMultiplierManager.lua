local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.ScoreMultiplierManager",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    get_BaseMultiplierSum = {
      name = "get_BaseMultiplierSum",
      offset = 0xB2E7F4,
    },
  },
})
