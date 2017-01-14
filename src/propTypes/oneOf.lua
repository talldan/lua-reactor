local function getFailureReason(actualValue)
  return 'Failed to validate prop as oneOf a set of options, ' ..
    'instead saw ' .. type(actualValue)
end

local function validate(optionsDescription, toValidate)
  for _, optionValidator in ipairs(optionsDescription) do
    if optionValidator(toValidate) then
      return true
    end
  end

  return false, getFailureReason(toValidate)
end

local function oneOf(optionsDescription)
  assert(type(optionsDescription) == 'table',
    'oneOf validator expected optionsDescription to be expressed as a table')

  return function(toValidate)
    return validate(optionsDescription, toValidate)
  end
end

return oneOf