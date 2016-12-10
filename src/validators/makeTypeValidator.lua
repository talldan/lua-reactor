local function makeTypeValidator(typeName)

  local function validator(propTypeDeclaration, property)
    assert(type(propTypeDeclaration) == 'table',
      'expected prop type declaration to be a table')

    assert(type(propTypeDeclaration.required) == 'boolean',
      'expected prop type declaration to have an required boolean property')

    assert(propTypeDeclaration.propTypeName == typeName,
      'expected prop type declaration to have a propTypeName of' ..typeName)

    local isValid = false
    local required = propTypeDeclaration.required

    if type(property) == typeName then
      isValid = true
    end
    
    if not required and property == nil then
      isValid = true
    end

    return isValid
  end

  return validator
end

return makeTypeValidator