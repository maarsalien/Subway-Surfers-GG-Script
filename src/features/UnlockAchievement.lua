local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local Achievement = require("klasses.Achievement")

return feature({
  name = "Unlock Achievement",
  desc = "Makes all achievements available to claim.",
  state = false,
  isAvailable = (function(self) return true end)(),
  onDisableExceptionHandler = function(self, exception)
    ggx.alert("Failed to disable " .. self.name .. ":  \n" .. exception)
    ggx.copyText(exception, true)
  end,
  onEnableExceptionHandler = function(self, exception)
    ggx.alert("Failed to enable " .. self.name .. ":  \n" .. exception)
    ggx.copyText(exception, true)
  end,
  onEnable = {
    function(self, event)
      memory.patchV7(
        Achievement.methods.get_IsTierCompleted.address,
        false, false,
        "mov r0, #1", "bx lr"
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
        Achievement.methods.get_IsTierCompleted.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  },
})
