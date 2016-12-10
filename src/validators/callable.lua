local function callableValidator(propTypeDeclaration, property)
  assert(type(propTypeDeclaration) == 'table',
    'expected prop type declaration to be a table')

  assert(type(propTypeDeclaration.required) == 'boolean',
    'expected prop type declaration to have an required boolean property')

  assert(propTypeDeclaration.propTypeName == 'callable',
    'expected prop type declaration to have a propTypeName of callable')

  local isValid = false
  local required = propTypeDeclaration.required

  if type(property) == 'function' then
    isValid = true
  end

  if type(property) == 'table' then
    local metatable = getmetatable(property)
    if type(metatable) == 'table' then
      isValid = type(metatable.__call) == 'function'
    end
  end

  if not required and property == nil then
    isValid = true
  end

  return isValid
end

return callableValidator