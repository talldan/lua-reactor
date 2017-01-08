local function validateString()
  return function(toValidate)
    return type(toValidate) == 'string'
  end
end

return validateString