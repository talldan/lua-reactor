local path = (...):gsub("%.propTypes.value$","")
local getPrintableValue = require(path .. '.helpers.getPrintableValue')

local function getFailureReason(description, actualValue)
  local printableDescription = getPrintableValue(description)
  local printableValue = getPrintableValue(actualValue)

  return 'Failed to validate prop as value ' .. printableDescription ..
    ', instead saw ' .. printableValue
end

local function value(description)
  assert(description ~= nil,
    'value validator expects its argument to be a non-nil value')

  return function(toValidate)
    local isValid = toValidate == description
    local reason = nil

    if not isValid then
      reason = getFailureReason(description, toValidate)
    end

    return isValid, reason
  end
end

return value