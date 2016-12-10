local path = (...):gsub("%.string$","")
local makeTypeValidator = require(path .. '.makeTypeValidator')
local stringValidator = makeTypeValidator('string')

return stringValidator