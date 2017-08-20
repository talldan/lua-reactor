local curry = require('reactor.utils.funcUtils').curry
local assign = require('reactor.utils.tableUtils').assign
local component = require('reactor').component

local function createLeafNode(componentConfig)
  local renderFunc = curry(function(props, path)
    return {
      name = componentConfig.name,
      operations = componentConfig.operations,
      canHaveChildren = componentConfig.canHaveChildren,
      props = props,
      path = path
    }
  end, 2)

  local configWithRenderFunc = assign({
    render = renderFunc
  }, componentConfig)

  return component(configWithRenderFunc)
end

return createLeafNode