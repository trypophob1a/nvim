local checker = {}

function checker.hasMethod(module, methodName)
  return type(module) == "table" and type(module[methodName]) == "function"
end

return checker
