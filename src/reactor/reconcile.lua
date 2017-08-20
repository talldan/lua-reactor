-- todo
-- * do not modify the list of operations
-- * get operations for children

local assign = require('reactor.utils.tableUtils').assign

return function()
  local collectionDiff, nodeDiff, diff, recurseThroughCollection

  local function isCollection(tbl)
    return type(tbl) == 'table' and
      not tbl.name and not tbl.props and
      not tbl.parent
  end

  local function isParentAndChildren(node)
    return type(node) == 'table' and node.parent
  end

  local function isNewNode(current, last)
    return current and not last
  end

  local function isRemovedNode(current, last)
    return not current and last
  end

  local function push(sourceTable, entry)
    sourceTable[#sourceTable + 1] = entry
    return sourceTable
  end

  local function getIndex(collection, index)
    if collection and collection[index] then
      return collection[index]
    end

    return nil
  end

  local function getNode(nodeContainer)
    if isParentAndChildren(nodeContainer) then
      return nodeContainer.parent
    else
      return nodeContainer
    end
  end

  local function getChildren(nodeContainer)
    if isParentAndChildren(nodeContainer) then
      return nodeContainer.children
    end
  end

  local function hasSameComponentName(current, last)
    return current.name == last.name
  end

  local function create(description)
    return assign({
      operationType = 'create',
      path = description.path,
      props = description.props
    }, description.operations)
  end

  local function update(description)
    return assign({
      operationType = 'update',
      path = description.path,
      props = description.props
    }, description.operations)
  end

  local function delete(description)
    return assign({
      operationType = 'delete',
      path = description.path,
      props = description.props
    }, description.operations)
  end

  local function postChildUpdate(description)
    return assign({
      operationType = 'postChildUpdate',
      path = description.path,
      props = description.props
    }, description.operations)
  end

  collectionDiff = function (current, last, operations)
    local isCollectionCurrent = isCollection(current)
    local isCollectionLast = isCollection(last)

    if isCollectionCurrent and isCollectionLast then
      operations = recurseThroughCollection(
        current,
        last,
        1,
        operations
      )
    elseif not isCollectionCurrent and isCollectionLast then
      if current then
        operations = diff(current, nil, operations)
      end

      operations = recurseThroughCollection(
        {},
        last,
        1,
        operations
      )
    elseif isCollectionCurrent and not isCollectionLast then
      if last then
        operations = diff(nil, last, operations)
      end

      operations = recurseThroughCollection(
        current,
        {},
        1,
        operations
      )
    end

    return operations
  end

  nodeDiff = function(current, last, operations)
    local currentNode = getNode(current)
    local lastNode = getNode(last)

    if isNewNode(currentNode, lastNode) then
      push(operations, create(currentNode))
    elseif isRemovedNode(currentNode, lastNode) then
      push(operations, delete(lastNode))
    elseif hasSameComponentName(currentNode, lastNode) then
      push(operations, update(currentNode))
    else
      push(operations, delete(lastNode))
      push(operations, create(currentNode))
    end

    local currentChildren = getChildren(current)
    local lastChildren = getChildren(last)

    if currentChildren or lastChildren then
      operations = diff(currentChildren, lastChildren, operations)
    end

    if currentNode and currentChildren then
      push(operations, postChildUpdate(currentNode))
    end

    return operations
  end

  recurseThroughCollection = function(current, last, currentIndex, operations)
    local currentNode = getIndex(current, currentIndex)
    local lastNode = getIndex(last, currentIndex)

    if not currentNode and not lastNode then
      return operations
    end

    -- get the operations for the current node
    operations = diff(
      currentNode,
      lastNode,
      operations
    )

    -- recurse to the next node
    return recurseThroughCollection(
      current,
      last,
      currentIndex + 1,
      operations
    )
  end

  diff = function(current, last, operations)
    if isCollection(current) or isCollection(last) then
      operations = collectionDiff(current, last, operations)
    else
      operations = nodeDiff(current, last, operations)
    end
    return operations
  end

  return function(current, last)
    assert(type(current) == 'table',
      'reconcile expects a table as its first argument')
    assert(last == nil or type(last) == 'table',
        'reconcile expects a table or nil as its second argument')
    return diff(current, last, {})
  end
end