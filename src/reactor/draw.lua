local function drawModule(reactor)
  local previousDrawDescription

  local function draw(drawComponents)
    local drawDescription = drawComponents()
    local drawOperations = reactor.reconcile(
      drawDescription,
      previousDrawDescription
    )
    reactor.invoke(drawOperations)
    previousDrawDescription = drawDescription
  end

  return draw
end

return drawModule