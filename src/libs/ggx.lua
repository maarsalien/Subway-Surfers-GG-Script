local ggx    = gg
local table  = table
local string = string


function ggx.readHexBytes(address, bitLength, processPause)
  if (processPause and not ggx.isProcessPaused()) then ggx.processPause() end
  ggx.sleep(100)

  local hex = ""
  bitLength = bitLength or 8
  for i = 1, bitLength do
    local value = ggx.getValues({ { address = address + i - 1, flags = ggx.TYPE_BYTE } })[1]
    local v = value.value % 256
    if v < 0 then v = v + 256 end
    hex = string.format("%s%02X", hex, v)
  end

  if (processPause and ggx.isProcessPaused()) then ggx.processResume() end
  return hex
end

function ggx.hexWrite(address, hex, freeze, processPause)
  if (processPause and not ggx.isProcessPaused()) then ggx.processPause() end
  ggx.sleep(100)

  local values = {}
  for i = 1, #hex - 1, 2 do
    table.insert(values, {
      address = address,
      freeze  = freeze,
      flags   = ggx.TYPE_BYTE,
      value   = tonumber(hex:sub(i, i + 1), 16)
    })
    address = address + 1
  end

  ggx.setValues(values)
  if (freeze) then ggx.addListItems(values) end
  if (processPause and ggx.isProcessPaused()) then ggx.processResume() end
end

function ggx.asmWrite(address, freeze, processPause, ...)
  if (processPause and not ggx.isProcessPaused()) then ggx.processPause() end
  ggx.sleep(100)

  local args = { ... }
  local values = {}
  for i = 1, #args do
    table.insert(values, {
      address = address,
      flags   = ggx.TYPE_DWORD,
      value   = args[i]
    })
    address = address + 4
  end

  ggx.setValues(values)
  if (freeze) then ggx.addListItems(values) end
  if (processPause and ggx.isProcessPaused()) then ggx.processResume() end
end

function ggx.armv7Write(address, freeze, processPause, ...)
  local opcodes = { ... }
  for k, v in ipairs(opcodes) do
    opcodes[k] = string.format("~A %s", v)
  end
  ggx.asmWrite(address, freeze, processPause, table.unpack(opcodes))
end

return ggx
