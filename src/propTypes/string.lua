local function validateString()
  return function(toValidate)
    local isValid = type(toValidate) == 'string'
    local reason = nil

    if not isValid then
      reason =
        'failed to validate prop as string, instead saw ' .. type(toValidate)
    end

    return isValid, reason
  end
end

return validateString