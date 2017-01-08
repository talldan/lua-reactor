local function value(description)
  assert(description ~= nil,
    'value validator expects its argument to be a non-nil value')

  return function(toValidate)
    return toValidate == description
  end
end

return value