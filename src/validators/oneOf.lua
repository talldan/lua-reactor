local function oneOfValidator(propTypeDeclaration, property)
  assert(type(propTypeDeclaration) == 'table',
    'expected prop type declaration to be a table')

  assert(type(propTypeDeclaration.required) == 'boolean',
    'expected prop type declaration to have an required boolean property')

  assert(propTypeDeclaration.propTypeName == 'oneOf',
    'expected prop type declaration to have a propTypeName of oneOf')

  local validationData = propTypeDeclaration.validationData

  assert(type(validationData) == 'table' and #validationData > 0,
    'expected prop type declaration for oneOf to specify a table of values')

  local isValid = false
  local required = propTypeDeclaration.required

  if not required and property == nil then
    isValid = true
  else
    for _, validValue in ipairs(validationData) do
      if validValue == property then
        isValid = true
        break
      end
    end
  end

  return isValid
end

return oneOfValidator