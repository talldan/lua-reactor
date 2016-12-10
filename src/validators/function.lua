local path = (...):gsub("%.function$","")
local makeTypeValidator = require(path .. '.makeTypeValidator')
local functionValidator = makeTypeValidator('function')

return functionValidator