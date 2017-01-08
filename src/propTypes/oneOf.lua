local function validate(optionsDescription, toValidate)
  for _, optionValidator in ipairs(optionsDescription) do
    if optionValidator(toValidate) then
      return true
    end
  end

  local reason = 'Failed to validate prop as oneOf a set of options, ' ..
    'instead saw ' .. type(toValidate)

  return false, reason
end

local function oneOf(optionsDescription)
  assert(type(optionsDescription) == 'table',
    'oneOf validator expected optionsDescription to be expressed as a table')

  return function(toValidate)
    local isValid, reason = validate(optionsDescription, toValidate)
    return isValid, reason
  end
end

return oneOf