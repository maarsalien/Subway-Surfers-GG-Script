local ggx = require("libs.ggx")

local app = ggx.getTargetInfo()

if (not app) then
  error("Target is not set")
end

return app
