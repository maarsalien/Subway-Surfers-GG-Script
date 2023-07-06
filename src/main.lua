require("firstpass.index")
local ggx = require("libs.ggx")
local features = require("features.index")
local os = os
local f = string.format
local table = table

local totalFeatures = features:size() + 1

local function main()
  local items = features:map(function(ft)
    local function fr(str) return f("「%s」", str) end
    local state = ft.state and "◆" or "◇"
    local l1 = f("%s", fr(state))
    local l2 = f("%s", ft.name)
    local l3 = f("%s", ft.desc)
    return f("%s\n%s\n%s\n", l1, l2, l3)
  end)

  table.insert(items, "Exit")

  local index = ggx.choice(items, nil, "Select a feature to enable/disable")
  if not index then
    do return end
  end

  if index == totalFeatures then
    do os.exit() end
  end

  features:at(index)()
  main()
end

while true do
  if (ggx.isVisible()) then
    ggx.setVisible(false)
    main()
  end
  ggx.sleep(100)
end
