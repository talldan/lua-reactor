-- luacheck: globals love

local createLeafNode = require('reactor.helpers.createLeafNode')

local function create(props)
  local vertexShader = props.vertexShader
  local pixelShader = props.pixelShader

  if vertexShader and pixelShader then
    return love.graphics.newShader(vertexShader, pixelShader)
  elseif vertexShader then
    return love.graphics.newShader(vertexShader)
  elseif pixelShader then
    return love.graphics.newShader(pixelShader)
  end
end

local function update(_, nextProps, drawable)
  if type(nextProps.externs) == 'table' then
    for key, value in pairs(nextProps.externs) do
      drawable:send(key, value)
    end
  end

  return drawable
end

local function draw(_, drawable)
  love.graphics.setShader(drawable)
  return drawable
end

local function postChildUpdate()
  love.graphics.setShader()
end


local shaderOperations = {
  create = create,
  update = update,
  draw = draw,
  postChildUpdate = postChildUpdate
}

return createLeafNode({
  name = 'drawable',
  operations = shaderOperations,
  canHaveChildren = true
});
