local function validateFunction()
  return function(toValidate)
    local isValid = type(toValidate) == 'function'
    local reason = nil

    if not isValid then
      reason =
        'failed to validate prop as function, instead saw ' .. type(toValidate)
    end

    return isValid, reason
  end
end

return validateFunction