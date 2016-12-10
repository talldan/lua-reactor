local path = (...):gsub("%.number$","")
local makeTypeValidator = require(path .. '.makeTypeValidator')
local numberValidator = makeTypeValidator('number')

return numberValidator