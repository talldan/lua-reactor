local function validateNumber()
  return function(toValidate)
    local isValid = type(toValidate) == 'number'
    local reason = nil

    if not isValid then
      reason =
        'Failed to validate prop as number, instead saw ' .. type(toValidate)
    end

    return isValid, reason
  end
end

return validateNumber