local function isTableType(toValidate)
  return type(toValidate) == 'table'
end

local function getTableKeys(tableWithKeys)
  local keys = {}

  for key in pairs(tableWithKeys) do
    keys[#keys + 1] = key
  end

  return keys
end

local function hasAllKeys(toValidate, shapeDescription)
  local descritionKeys = getTableKeys(shapeDescription)
  local keysToValidate = getTableKeys(toValidate)

  if (#descritionKeys ~= #keysToValidate) then
    return false
  end

  for index, keyDescription in ipairs(descritionKeys) do
    local keyToValidate = keysToValidate[index]

    if keyDescription ~= keyToValidate then 
      return false 
    end
  end

  return true
end

local function hasValidProperties(toValidate, shapeDescription)
  for index, validator in pairs(shapeDescription) do
    local propertyToValidate = toValidate[index]
    local isValid = validator(propertyToValidate)

    if not isValid then
      return false
    end
  end

  return true
end

local function tableShape(shapeDescription)
  assert(type(shapeDescription) == 'table',
    'tableShape validator expected shapeDescription to be expressed as a table')

  return function(toValidate)
    return isTableType(toValidate) and
      hasAllKeys(toValidate, shapeDescription) and
      hasValidProperties(toValidate, shapeDescription)
  end
end

return tableShape