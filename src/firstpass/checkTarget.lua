local ggx = require("libs.ggx")
local application = require("application")

local scriptName = [=====[Script for Subway Surf 3.14.0]=====]
local scriptVersion = '1.0.0'
local scriptAuthor = 'Maars'
local startToast = 'Script started.'
-- 0 - no check; 1 - check package only, 2 - check package and build, 3 - abi check
local checkTarget = 3

local targetName = [=====[Subway Surf]=====]
local targetPkg = 'com.kiloo.subwaysurf'
local targetVersion = [=====[3.14.1]=====]
local targetBuild = 58799

ggx.require('101.1', 16142)

if startToast ~= '' then startToast = '\n' .. startToast end
ggx.toast(scriptName .. ' v' .. scriptVersion .. ' by ' .. scriptAuthor .. startToast)

if checkTarget ~= 0 then
  local info = application

  local check
  local current
  if checkTarget >= 1 then
    check = targetPkg
    current = info.packageName
  end
  if checkTarget >= 2 then
    check = check .. ' ' .. targetVersion .. ' (' .. targetBuild .. ')'
    current = current .. ' ' .. info.versionName .. ' (' .. info.versionCode .. ')'
  end
  if check ~= current then
    ggx.alert('This script for "' ..
      targetName ..
      '" [' .. check .. '].\nYou select "' .. info.label .. '" [' .. current .. '].\nNow script exit.')
    os.exit()
  end

  if checkTarget >= 3 then
    if (application.x64) then
      ggx.alert('This script only for 32 bit application.\nNow script exit.')
      os.exit()
    end
  end
end
