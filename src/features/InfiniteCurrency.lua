local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local WalletModel = require("klasses.WalletModel")

return feature({
  name = "Infinite Currency",
  desc = "Make all currency infinite.",
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
        WalletModel.methods.GetCurrency.address,
        false, false,
        "movw r0, #0xE0FF",
        "movt r0, #0x05F5",
        "bx lr"
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
        WalletModel.methods.GetCurrency.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  },
})
