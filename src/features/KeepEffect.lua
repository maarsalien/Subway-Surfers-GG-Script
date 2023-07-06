local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local CharacterEffectsController = require("klasses.CharacterEffectsController")

return feature({
  name = "Keep Effect",
  desc = "Keep roll dirt, grind, shadow, dizzy stars, and bush leaves effects.",
  state = false,
  isAvailable = (function(self) return true end)(),
  onDisableExceptionHandler = function(self, exception)
    ggx.alert("Failed to disable " .. self.name .. ":  \n" .. exception)
    ggx.copyText(exception, false)
  end,
  onEnableExceptionHandler = function(self, exception)
    ggx.alert("Failed to enable " .. self.name .. ":  \n" .. exception)
    ggx.copyText(exception, false)
  end,
  onEnable = {
    function(self, event)
      memory.patchV7(
        CharacterEffectsController.methods.HideBushLeaves.address,
        false, false,
        "nop", "bx lr"
      )
      memory.patchV7(
        CharacterEffectsController.methods.HideDizzyStars.address,
        false, false,
        "nop", "bx lr"
      )
      memory.patchV7(
        CharacterEffectsController.methods.HideGrind.address,
        false, false,
        "nop", "bx lr"
      )
      memory.patchV7(
        CharacterEffectsController.methods.HideRollDirt.address,
        false, false,
        "nop", "bx lr"
      )
      memory.patchV7(
        CharacterEffectsController.methods.HideShadow.address,
        false, false,
        "nop", "bx lr"
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Enabled " .. self.name .. ".")
    end
  },
  onDisable = {
    function()
      memory.restore(
        false, false,
        CharacterEffectsController.methods.HideBushLeaves.address,
        CharacterEffectsController.methods.HideDizzyStars.address,
        CharacterEffectsController.methods.HideGrind.address,
        CharacterEffectsController.methods.HideRollDirt.address,
        CharacterEffectsController.methods.HideShadow.address
      )
    end,
    function(self, event)
      ggx.toast("Disabled " .. self.name .. ".")
    end
  },
})
