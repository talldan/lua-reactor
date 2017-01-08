local function getFailureReason(toValidate)
  local valueType = type(toValidate)

  if valueType == 'table' then
    valueType = 'non-callable table'
  end

  return 'Failed to validate prop as callable, instead saw ' .. valueType
end

local function isFunction(toValidate)
  return type(toValidate) == 'function'
end

local function isCallableTable(toValidate)
  if type(toValidate) ~= 'table' then
    return false
  end

  local metatable = getmetatable(toValidate)

  if type(metatable) ~= 'table' then
    return false
  end

  return isFunction(metatable.__call)
end

local function callable()
  return function(toValidate)
    local isValid = isFunction(toValidate) or isCallableTable(toValidate)
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return callable