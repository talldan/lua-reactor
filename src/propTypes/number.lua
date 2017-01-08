local function validateNumber()
  return function(toValidate)
    return type(toValidate) == 'number'
  end
end

return validateNumber