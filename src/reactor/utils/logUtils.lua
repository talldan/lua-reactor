local logString, logBoolean, logKey, logTable, getPrintableValue

local function getPadding(amount)
  return string.rep(' ', amount)
end

logString = function(value)
  return "'" .. value .. "'"
end

logBoolean = function(bool)
  return bool and 'true' or 'false'
end

logKey = function(key, value)
  return key .. ' = ' .. value
end

logTable = function(tbl, pad)
  local outerPadding = getPadding(pad)
  local innerPadding = getPadding(pad + 2)

  local tblValues = {}
  for key, value in pairs(tbl) do
    tblValues[#tblValues + 1] = innerPadding ..
      logKey(key, getPrintableValue(value, pad + 2))
  end

  return '{\n' .. table.concat(tblValues, ',\n') .. '\n' .. outerPadding .. '}'
end

getPrintableValue = function(value, pad)
  local output = ''

  if not pad then
    pad = 0
  end

  if value == nil then
    output = output .. '<nil>'
  elseif type(value) == 'string' then
    output = output .. logString(value)
  elseif type(value) == 'number' then
    output = output .. value
  elseif type(value) == 'boolean' then
    output = output .. logBoolean(value)
  elseif type(value) == 'function' then
    output = output .. '<function()>'
  elseif type(value) == 'table' then
    output = output .. logTable(value, pad)
  else
    output = output .. '<' .. type(value) .. '>'
  end

  return output
end

local function printValue(value)
  print(getPrintableValue(value))
end

return {
  getPrintableValue = getPrintableValue,
  printValue = printValue
}