local function getPrintableValue(value)
  if value == nil then
    return 'nil'
  elseif type(value) == 'function' then
    return 'a function'
  elseif value == true then
    return 'true'
  elseif value == false then
    return 'false'
  elseif type(value) == 'function' then
    return 'a function'
  elseif type(value) == 'table' then
    return 'a table'
  else
    return value
  end
end

return getPrintableValue