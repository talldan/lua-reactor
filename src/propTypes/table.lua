local function getFailureReason(actualValue)
  return 'Failed to validate prop as table, instead saw ' .. type(actualValue)
end

local function validateTable()
  return function(toValidate)
    local isValid = type(toValidate) == 'table'
    local reason = nil

    if not isValid then
      reason = getFailureReason(toValidate)
    end

    return isValid, reason
  end
end

return validateTable