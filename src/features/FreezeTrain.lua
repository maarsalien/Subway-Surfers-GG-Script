local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local MovingTrain = require("klasses.MovingTrain")

return feature({
  name = "Freeze Train",
  desc = "Freeze the train in place.",
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
        MovingTrain.methods.Update.address,
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
    function(self, event)
      memory.restore(
        false, false,
        MovingTrain.methods.Update.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  }
})
