local function getFailureReason(actualValue)
  return 'Failed to validate prop as string, instead saw ' .. type(actualValue)
end

local function validateString()
  return function(toValidate)
    local isValid = type(toValidate) == 'string'
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return validateString