local function validateTable()
  return function(toValidate)
    return type(toValidate) == 'table'
  end
end

return validateTable