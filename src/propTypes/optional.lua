local function optional(validateNormally)
  assert(type(validateNormally) == 'function',
    'expected validator supplied to optional to be of type function')

  return function(toValidate)
    if toValidate == nil then
      return true
    else
      local isValid, reason = validateNormally(toValidate)
      return isValid, reason
    end
  end
end

return optional