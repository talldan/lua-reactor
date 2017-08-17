-- luacheck: globals love

local createLeafNode = require('helpers.createLeafNode')

local function create(props)
  local mode = props.mode or "fan"
  local usage = props.usage or "dynamic"
  local vertices = props.vertices
  local vertexFormat = props.vertexFormat

  if vertexFormat then
    return love.graphics.newMesh(vertexFormat, vertices, mode, usage)
  else
    return love.graphics.newMesh(vertices, mode, usage)
  end
end

local function update(previousProps, nextProps, drawable)
    -- todo - its hard to compare a list of vertices
  -- due to object equality issues, find a way to fix this
  -- if previous.vertices ~= next.vertices then
  --   drawable.setVertices(drawable, next.vertices)
  --   print('redraw')
  -- end

  if previousProps.mode ~= nextProps.mode then
    drawable.setDrawMode(nextProps.mode)
  end

  return drawable
end

local function draw(props, drawable)
  local x = props.x or 0
  local y = props.y or 0
  local rotation = props.rotation or 0
  local scaleX = props.scaleX or 1
  local scaleY = props.scaleY or 1

  love.graphics.draw(drawable, x, y, rotation, scaleX, scaleY)

  return drawable
end

local meshOperations = {
  create = create,
  update = update,
  draw = draw
}

return createLeafNode({
  name = 'drawable',
  operations = meshOperations,
  canHaveChildren = false
});