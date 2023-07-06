local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.Subway.CharacterEffectsController",
  assemblyName = "Assembly-CSharp.dll",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    HideBushLeaves = {
      name = "HideBushLeaves",
      offset = 0x76B914,
    },
    HideDizzyStars = {
      name = "HideDizzyStars",
      offset = 0x76B398,
    },
    HideGrind = {
      name = "HideGrind",
      offset = 0x76BC38,
    },
    HideRollDirt = {
      name = "HideRollDirt",
      offset = 0x76BA7C,
    },
    HideShadow = {
      name = "HideShadow",
      offset = 0x76B224,
    },
  },
})
