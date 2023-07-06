local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local Currency = require("klasses.Currency")

return feature({
  name = "Free In-App Purchases",
  desc = "Make all in-app purchases free of charge.",
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
        Currency.methods.get_IsIAP.address,
        false, false,
        "mov r0, #0", "bx lr"
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
        Currency.methods.get_IsIAP.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  }
})
