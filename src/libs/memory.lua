local ggx = require("libs.ggx")
local array = require("libs.array")
local isModuleName = require("libs.helper").isModuleName
local table = table

local mem = {}

local originalBytes = array.new()

local function backupBytes(address, lengh, processPause)
  if (not originalBytes:find(function(item) return item.address == address end)
      ) then
    originalBytes:push({
      bytes = ggx.readHexBytes(address, lengh, processPause),
      address = address,
    })
  end
end

function mem.findModuleExportByName(module)
  assert(isModuleName(module), "Invalid module name")
  for _, range in ipairs(ggx.getRangesList(module)) do
    if range.state == "Xa" then
      do return range end
    end
  end
end

function mem.restore(freeze, processPause, ...)
  local args = { ... }
  local result = {}

  for _, address in ipairs(args) do
    local original = originalBytes:find(function(item)
      return item.address == address
    end)

    if (original) then
      ggx.hexWrite(address, original.bytes, freeze, processPause)
      table.insert(result, true)
    else
      table.insert(result, false)
    end
  end

  return result
end

function mem.patchV7(address, freeze, processPause, ...)
  local opcodes = { ... }
  -- mem.restore(address, freeze, processPause)
  backupBytes(address, #opcodes * 4, processPause)
  ggx.armv7Write(address, freeze, processPause, table.unpack(opcodes))
end

function mem.patchHEX(address, hex, freeze, processPause)
  hex = hex:gsub("%s+", "")
  -- mem.restore(address, freeze, processPause)
  backupBytes(address, #hex / 2, processPause)
  ggx.hexWrite(address, hex, freeze, processPause)
end

return mem
