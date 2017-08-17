local function componentModule(reactor)
  local function hasName(component)
    return type(component.name) == 'string'
  end

  local function hasRenderFunction(component)
    return type(component.render) == 'function'
  end

  local function validateComponent(component)
    assert(hasName(component),
      'component declared without a name property')
    assert(hasRenderFunction(component),
      'component declared without a render function')
  end

  return function(component)
    validateComponent(component)
    return reactor.lifecycle(component)
  end
end

return componentModule
