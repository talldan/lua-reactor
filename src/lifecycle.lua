local curry = require('utils.funcUtils').curry
local map = require('utils.tableUtils').map

local function lifecycleModule(reactor)
  local function updatePath(component, props, path)
    local updatedPath
    local key = props and props.key
    local name = component and component.name
    local pathPart = key or name

    if not path then
      path = ''
    end

    if path ~= '' then
      updatedPath = path .. '.' .. pathPart
    else
      updatedPath = pathPart
    end

    return updatedPath
  end

  local function preRender(component, props, lastProps)
    if lastProps then
      if component.willUpdate then
        component.willUpdate(props, lastProps)
      end
    else
      if component.willMount then
        component.willMount(props)
      end
    end
  end

  local function renderTable(componentRenderers, path)
    return map(function(render)
      return render(path)
    end, componentRenderers)
  end

  local function render(renderer, path)
    if type(renderer) == 'table' then
      return renderTable(renderer, path)
    elseif type(renderer) == 'function' then
      return renderer(path)
    end
  end

  local function doRender(component, props, path)
    local renderer = component.render(props)
    local renderOutput

    if props.children then
      renderOutput = {
        parent = render(renderer, path),
        children = render(props.children, path .. '.children')
      }
    else
      renderOutput = render(renderer, path)
    end

    reactor.registry.mountComponentIfRequired(component, props, path)

    return renderOutput
  end

  local function postRender(component, props, lastProps)
    if lastProps then
      if component.didUpdate then
        component.didUpdate(props, lastProps)
      end
    else
      if component.didMount then
        component.didMount(props)
      end
    end
  end

  local function lifecycle(component, props, path)
    local renderPath = updatePath(component, props, path)
    local lastProps = reactor.registry.getLastProps(renderPath)

    preRender(component, props, lastProps)
    local renderOutput = doRender(component, props, renderPath)
    postRender(component, props, lastProps)

    return renderOutput
  end

  return curry(lifecycle, 3)
end

return lifecycleModule