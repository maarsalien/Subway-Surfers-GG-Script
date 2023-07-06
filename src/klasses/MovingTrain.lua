local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.MovingTrain",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    Update = {
      name = "Update",
      offset = 0xB0D6A4,
    },
  },
})
