local array = require("libs.array")

return array.new(
  require("features.KeepEffect"),
  require("features.NoImpact"),
  require("features.NoBoundary"),
  require("features.NoGravity"),
  require("features.ScoreMultiplier"),
  require("features.UnlockAchievement"),
  require("features.FreezeTrain"),
  require("features.InfiniteCurrency"),
  require("features.FreeInAppPurchases"),
  require("features.PowerUpController")
)
