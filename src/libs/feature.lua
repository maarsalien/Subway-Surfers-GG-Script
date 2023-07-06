local isFunction = require("libs.helper").isFunction
local setmetatable = setmetatable
local f = string.format

local meta = {
  __call = function(self)
    local eventList = self.state and self.onDisable or self.onEnable
    local callbacks = isFunction(eventList) and { eventList } or eventList
    local exceptionHandler = self.state and self.onDisableExceptionHandler or self.onEnableExceptionHandler

    local event = {}
    for _, fn in ipairs(callbacks) do
      local success, error = pcall(fn, self, event)
      if not success and exceptionHandler then
        event.error = true
        exceptionHandler(self, error, event)
      end
      if (event.error or event.abort) then return end
    end

    self.state = not self.state
  end,
  __newindex = function(self, key, value)
    print(key, value)
    error(f("Can not add new index to a feature at runtime. (%s)", self.name))
  end
}

return setmetatable({}, {
  __call = function(self, feature)
    return setmetatable(feature, meta)
  end
})
