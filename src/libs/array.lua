local table = table
local array = setmetatable({}, table)
array.__index = array

function array.new(...)
  local self = setmetatable({}, array)
  self:push(...)
  return self
end

function array:push(...)
  for _, v in ipairs({ ... }) do
    table.insert(self, v)
  end
  return self
end

function array:size()
  return #self
end

function array:at(index)
  return self[index]
end

function array:find(fn)
  for i, v in ipairs(self) do
    if fn(v, i) then
      do return v end
    end
  end
end

function array:map(fn)
  local arr = array.new()
  for i, v in ipairs(self) do
    arr:push(fn(v, i))
  end
  return arr
end

return array
