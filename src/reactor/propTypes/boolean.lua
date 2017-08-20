local function getFailureReason(actualValue)
  return 'Failed to validate prop as boolean, instead saw ' .. type(actualValue)
end

local function validateBoolean()
  return function(toValidate)
    local isValid = type(toValidate) == 'boolean'
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return validateBoolean