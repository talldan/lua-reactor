local function validateBoolean()
  return function(value)
    return type(value) == 'boolean'
  end
end

return validateBoolean