local function validateTable()
  return function(toValidate)
    local isValid = type(toValidate) == 'table'
    local reason = nil

    if not isValid then
      reason =
        'failed to validate prop as table, instead saw ' .. type(toValidate)
    end

    return isValid, reason
  end
end

return validateTable