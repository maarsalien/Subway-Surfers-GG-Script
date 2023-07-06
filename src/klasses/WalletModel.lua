local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.Meta.WalletModel",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    GetCurrency = {
      name = "GetCurrency",
      offset = 0x9CA8CC,
    },
  },
})
