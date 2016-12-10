local function validateString(propTypeDeclaration, property)
  assert(type(propTypeDeclaration) == 'table',
    'expected prop type declaration to be a table')

  assert(type(propTypeDeclaration.required) == 'boolean',
    'expected prop type declaration to have an required boolean property')

  assert(propTypeDeclaration.propTypeName == 'string',
    'expected prop type declaration to have a propTypeName of string')

  local isValid = false
  local required = propTypeDeclaration.required

  if type(property) == 'string' then
    isValid = true
  end
  
  if not required and property == nil then
    isValid = true
  end

  return isValid
end

return validateString