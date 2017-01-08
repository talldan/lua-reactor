local function getPrintableValue(value)
  if value == nil then
    return 'nil'
  elseif type(value) == 'function' then
    return 'a function'
  elseif value == true then
    return 'true'
  elseif value == false then
    return 'false'
  elseif type(value) == 'function' then
    return 'a function'
  elseif type(value) == 'table' then
    return 'a table'
  else
    return value
  end
end

local function value(description)
  assert(description ~= nil,
    'value validator expects its argument to be a non-nil value')

  return function(toValidate)
    local isValid = toValidate == description
    local reason = nil

    if not isValid then
      local printableDescription = getPrintableValue(description)
      local printableValue = getPrintableValue(toValidate)

      reason = 'failed to validate prop as value ' .. printableDescription ..
        ', instead saw ' .. printableValue
    end

    return isValid, reason
  end
end

return value