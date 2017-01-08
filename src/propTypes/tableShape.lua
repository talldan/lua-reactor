local path = (...):gsub("%.propTypes.tableShape$","")
local getPrintableValue = require(path .. '.helpers.getPrintableValue')

local function isTableType(toValidate)
  local isValid = type(toValidate) == 'table'
  local reason = nil

  if not isValid then
    reason = 'failed to validate prop as tableShape, ' ..
      'expected table, but saw value of type ' .. type(toValidate)
  end

  return isValid, reason
end

local function getTableKeys(tableWithKeys)
  local keys = {}

  for key in pairs(tableWithKeys) do
    keys[#keys + 1] = key
  end

  return keys
end

local function hasAllKeys(toValidate, shapeDescription)
  local isValid = true
  local reason = nil

  local descritionKeys = getTableKeys(shapeDescription)
  local keysToValidate = getTableKeys(toValidate)

  isValid = #descritionKeys == #keysToValidate

  if not isValid then
    reason = 'Failed to validate prop as tableShape, ' ..
      'expected table to have ' .. #descritionKeys .. 'properties' 
    return isValid, reason
  end

  for index, keyDescription in ipairs(descritionKeys) do
    local keyToValidate = keysToValidate[index]

    isValid = keyDescription == keyToValidate

    if not isValid then 
      reason = 'Failed to validate prop as tableShape, ' ..
        'expected table to contain key: ' .. getPrintableValue(keyDescription)
      return isValid, reason 
    end
  end

  return true
end

local function hasValidProperties(toValidate, shapeDescription)
  for index, validator in pairs(shapeDescription) do
    local propertyToValidate = toValidate[index]
    local isValid, reason = validator(propertyToValidate)

    if not isValid then
      local reason = 'Failed to validate prop as tableShape, ' ..
        'property validation failed for key: ' .. getPrintableValue(index) ..
        '. Validation error: ' .. getPrintableValue(reason)
      return isValid, reason
    end
  end

  return true
end

local function tableShape(shapeDescription)
  assert(type(shapeDescription) == 'table',
    'tableShape validator expected shapeDescription to be expressed as a table')

  return function(toValidate)
    local isValid = true
    local reason = nil

    isValid, reason = isTableType(toValidate)

    if not isValid then
      return isValid, reason
    end

    isValid, reason = hasAllKeys(toValidate, shapeDescription)

    if not isValid then
      return isValid, reason
    end

    isValid, reason = hasValidProperties(toValidate, shapeDescription)

    if not isValid then
      return isValid, reason
    end

    return isValid
  end
end

return tableShape