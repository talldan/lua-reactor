local path = (...):gsub("%.table$","")
local makeTypeValidator = require(path .. '.makeTypeValidator')
local tableValidator = makeTypeValidator('table')

return tableValidator