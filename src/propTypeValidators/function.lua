local function validateFunction()
  return function(toValidate)
    return type(toValidate) == 'function'
  end
end

return validateFunction