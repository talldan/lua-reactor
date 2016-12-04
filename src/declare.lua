local path = (...):gsub("%.declare$","")
local validateProps = require(path .. '.validateProps')

local function declare(renderFunc, propTypes)
  assert(type(renderFunc) == 'function',
    'expected first argument to declare to be a function')

  return function(props, children, key)
    validateProps(propTypes, props)
    return renderFunc(props, children, key)
  end
end

return declare