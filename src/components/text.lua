-- luacheck: globals love

local createLeafNode = require('helpers.createLeafNode')

local function getFormattedText(props)
  local value = props.value
  local wraplimit = nil
  local alignment = 'left'

  if props.width ~= nil then
    wraplimit = props.width
  end

  if props.alignment ~= nil then
    alignment = props.alignment
  end

  return value, wraplimit, alignment
end

local function create(props)
  local fontSize = props.fontSize or 12
  local font = love.graphics.newFont(fontSize)
  local drawable = love.graphics.newText(font)
  drawable:setf(getFormattedText(props))
  return drawable
end

local function update(previousProps, nextProps, drawable)
  if previousProps.value ~= nextProps.value then
    drawable:setf(getFormattedText(nextProps))
  end

  return drawable
end

local function draw(props, drawable)
  local r, g, b, a = love.graphics.getColor()

  love.graphics.setColor(
    props.r or r,
    props.g or g,
    props.b or b,
    props.a or a
  )

  love.graphics.draw(drawable, props.x, props.y)

  love.graphics.setColor(r, g, b, a)

  return drawable
end

local textOperations = {
  create = create,
  update = update,
  draw = draw
}

return createLeafNode({
  name = 'text',
  operations = textOperations,
  canHaveChildren = false
});
