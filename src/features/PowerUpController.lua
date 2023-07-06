local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local UpgradesModel = require("klasses.UpgradesModel")

local string = string
local f = string.format

return feature({
  name = "Power Up Controller",
  desc = "Edit power ups level.",
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
      local prompt = ggx.prompt({ "Power Up Level [1;6]" }, { 1 }, { "number" })
      if (not prompt) then
        event.abort = true
        do return end
      end
      local powerUpLevel = tonumber(prompt[1])
      memory.patchV7(
        UpgradesModel.methods.GetPowerupLevel.address,
        false, false,
        f("mov r0, #%d", powerUpLevel), "bx lr"
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
        UpgradesModel.methods.GetPowerupLevel.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  },
})
