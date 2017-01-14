local function getFailureReason(actualValue)
  return 'Failed to validate prop as number, instead saw ' .. type(actualValue)
end

local function validateNumber()
  return function(toValidate)
    local isValid = type(toValidate) == 'number'
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return validateNumber