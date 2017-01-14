local path = (...):gsub("%.propTypes.tableShape$","")
local getPrintableValue = require(path .. '.helpers.getPrintableValue')

local function getIncorrectKeyCountFailureReason(keyCount)
  return 'Failed to validate prop as tableShape, ' ..
    'expected table to have ' .. keyCount .. 'properties'
end

local function getKeyMismatchFailureReason(expectedKey)
  return 'Failed to validate prop as tableShape, ' ..
    'expected table to contain key: ' .. getPrintableValue(expectedKey)
end

local function getPropertyValidationFailureReason(key, reason)
  return 'Failed to validate prop as tableShape, ' ..
    'property validation failed for key: ' .. getPrintableValue(key) ..
    '. Validation error: ' .. getPrintableValue(reason)
end

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

  table.sort(keys)

  return keys
end

local function hasAllKeys(toValidate, shapeDescription)
  local isValid = true
  local reason = nil

  local descritionKeys = getTableKeys(shapeDescription)
  local keysToValidate = getTableKeys(toValidate)

  isValid = #descritionKeys == #keysToValidate

  if not isValid then
    return isValid, getIncorrectKeyCountFailureReason(#descritionKeys)
  end

  for index, expectedKey in ipairs(descritionKeys) do
    local keyToValidate = keysToValidate[index]

    isValid = expectedKey == keyToValidate

    if not isValid then
      -- todo: this probably doesn't always return the right key! fix it
      return isValid, getKeyMismatchFailureReason(expectedKey)
    end
  end

  return true
end

local function hasValidProperties(toValidate, shapeDescription)
  for key, validator in pairs(shapeDescription) do
    -- todo: check that validator is function
    -- or use pcall to catch runtime errors
    local propertyToValidate = toValidate[key]
    local isValid, reason = validator(propertyToValidate)

    if not isValid then
      return isValid, getPropertyValidationFailureReason(key, reason)
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