local f = string.format

local meta = {
  __newindex = function(self, key, value)
    print(key, value)
    error(f("Can not add new index to a klass at runtime. (%s)", self.name))
  end
}

return setmetatable({}, {
  __call = function(self, klass)
    for _, v in pairs(klass.methods) do
      v.address = klass.nativelib.start + v.offset
    end
    return setmetatable(klass, meta)
  end
})
