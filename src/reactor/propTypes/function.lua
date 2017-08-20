local function getFailureReason(actualValue)
  return 'Failed to validate prop as function, instead saw ' .. type(actualValue)
end

local function validateFunction()
  return function(toValidate)
    local isValid = type(toValidate) == 'function'
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return validateFunction