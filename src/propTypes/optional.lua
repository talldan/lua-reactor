local function optional(validateNormally)
  assert(type(validateNormally) == 'function',
    'expected validator supplied to optional to be of type function')

  return function(toValidate)
    if toValidate == nil then
      return true
    else
      return validateNormally(toValidate)
    end
  end
end

return optional