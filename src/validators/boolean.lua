local path = (...):gsub("%.boolean$","")
local makeTypeValidator = require(path .. '.makeTypeValidator')
local booleanValidator = makeTypeValidator('boolean')

return booleanValidator