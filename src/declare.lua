local function validateTypes(propTypes, props)
  -- todo - implement it
end

local function declare(renderFunc, propTypes)
  assert(type(renderFunc) == 'function',
    'expected first argument to declare to be a function')

  return function(props, children, key)
    validateTypes(propTypes, props)
    return renderFunc(props, children, key)
  end
end

return declare