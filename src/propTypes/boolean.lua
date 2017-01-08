local function validateBoolean()
  return function(toValidate)
    local isValid = type(toValidate) == 'boolean'
    local reason = nil

    if not isValid then
      reason =
        'failed to validate prop as boolean, instead saw ' .. type(toValidate)
    end

    return isValid, reason
  end
end

return validateBoolean