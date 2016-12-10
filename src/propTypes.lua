local makePropType, makeCallable
local callableMetatable = {}

callableMetatable.__call = function(propType, propTypeValidationData)
  local newPropType = makePropType(propType.name)
  newPropType.validationData = propTypeValidationData
  return newPropType
end

makePropType = function(name, isCallable)
  local propType = {
    propTypeName = name,
    required = false,
    isRequired = {
      propTypeName = name,
      required = true
    }
  }

  if isCallable then
    makeCallable(propType)
  end

  return propType
end

makeCallable = function(propType)
  setmetatable(propType, callableMetatable)
  return propType
end

return {
  ['string'] = makePropType('string'),
  ['number'] = makePropType('number'),
  ['boolean'] = makePropType('boolean'),
  ['function'] = makePropType('function'),
  ['callable'] = makePropType('callable'),
  ['table'] = makePropType('table'),
  ['list'] = makePropType('list'),
  ['any'] = makePropType('any'),
  ['shape'] = makePropType('shape', true),
  ['listOf'] = makePropType('listOf', true),
  ['oneOf'] = makePropType('oneOf', true),
  ['oneOfType'] = makePropType('oneOfType', true)
}