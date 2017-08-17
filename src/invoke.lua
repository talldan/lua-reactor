local optionalMap = require('utils.tableUtils').optionalMap

local function invokeModule()
  local backingInstances = {}

  local function getCreationState(operation)
    if operation.create then
      return operation.create(operation.props)
    end
  end

  local function getUpdateState(operation, instance)
    if operation.update then
      local previousProps = nil
      local state = nil

      if type(instance) == 'table' then
        previousProps = instance.props
        state = instance.state
      end

      return operation.update(previousProps, operation.props, state)
    end
  end

  local function getDrawState(operation, instance)
    local state = nil

    if operation.draw then
      if type(instance) == 'table' then
        state = instance.state
      end
      return operation.draw(operation.props, state)
    end
  end

  local function createInstance(operation)
    local createdInstance = {
      state = getCreationState(operation),
      props = operation.props
    }

    return createdInstance, operation.path
  end

  local function updateInstance(operation, instance)
    local updatedInstance = {
      state = getUpdateState(operation, instance),
      props = operation.props
    }
    return updatedInstance, operation.path
  end

  local function drawInstance(operation, instance)
    local drawnInstance = {
      state = getDrawState(operation, instance),
      props = operation.props
    }
    return drawnInstance, operation.path
  end

  local function deleteInstance(operation)
    if operation.delete then
      operation.delete(operation.props)
    end
  end

  local function postChildUpdate(operation)
    if operation.postChildUpdate then
      operation.postChildUpdate(operation.props)
    end
  end

  local function getInstance(operation)
    return backingInstances[operation.path]
  end

  local function invoke(operations)
    backingInstances = optionalMap(function(operation)
      if operation['operationType'] == 'create' then
        local instance = createInstance(operation)
        return drawInstance(operation, updateInstance(operation, instance))
      elseif operation['operationType'] == 'update' then
        local instance = getInstance(operation)
        return drawInstance(operation, updateInstance(operation, instance))
      elseif operation['operationType'] == 'delete' then
        local instance = getInstance(operation)
        return deleteInstance(operation, instance)
      elseif operation['operationType'] == 'postChildUpdate' then
        local instance = getInstance(operation)
        return postChildUpdate(operation, instance)
      end
    end, operations)

    return backingInstances
  end

  return invoke
end

return invokeModule