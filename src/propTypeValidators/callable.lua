local function isCallableTable(toValidate)
  local metatable = getmetatable(toValidate)

  if metatable and type(metatable) == 'table' then
    return type(metatable.__call) == 'function'
  end

  return false
end

local function callable()
  return function(toValidate)
    if type(toValidate) == 'function' then
      return true
    elseif type(toValidate) == 'table' then
      return isCallableTable(toValidate)
    end

    return false
  end
end

return callable