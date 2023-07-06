local klass = require("libs.klass")
local libil2cpp = require("libs.nativelib").libil2cpp

return klass({
  name = "SYBO.RunnerCore.Character.CharacterMotor",
  assemblyName = "Assembly-CSharp",
  nativelib = libil2cpp,
  fields = {},
  methods = {
    ApplyGravity = {
      name = "ApplyGravity",
      offset = 0xBD4338,
    },
    IsChangingLaneTowardsBoundary = {
      name = "IsChangingLaneTowardsBoundary",
      offset = 0xBD0FF0,
    },
    CheckFrontalImpact = {
      name = "CheckFrontalImpact",
      offset = 0xBD4568,
    },
    CheckSideImpact = {
      name = "CheckSideImpact",
      offset = 0xBD4C4C,
    },
  },
})
