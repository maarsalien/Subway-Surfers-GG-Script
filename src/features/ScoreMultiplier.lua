local ggx = require("libs.ggx")
local memory = require("libs.memory")
local feature = require("libs.feature")
local ScoreMultiplierManager = require("klasses.ScoreMultiplierManager")

local string = string
local f = string.format


return feature({
  name = "Score Multiplier",
  desc = "Edit the score multiplier.",
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
      local prompt = ggx.prompt({ "Score Multiplier [1;50000]" }, { 1 }, { "number" })
      if (not prompt) then
        event.abort = true
        do return end
      end
      local scoreMultiplier = tonumber(prompt[1])
      memory.patchV7(
        ScoreMultiplierManager.methods.get_BaseMultiplierSum.address,
        false, false,
        f("movw r0, #0x%x", scoreMultiplier), "bx lr"
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
        ScoreMultiplierManager.methods.get_BaseMultiplierSum.address
      )
    end,
    function(self, event)
      if (event.error) then return end
      ggx.toast("Disabled " .. self.name .. ".")
    end
  }
})
