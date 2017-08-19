package = "reactor"
version = "scm-1"
source = {
  url = "git://github.com/talldan/lua-reactor.git"
}
description = {
  summary = "React-style ui component system for Lua",
  detailed = [[
    React-style ui component system for Lua.
  ]],
  homepage = "https://github.com/talldan/lua-reactor",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["reactor"] = "src/reactor.lua",
    ["component"] = "src/component.lua",
    ["draw"] = "src/draw.lua",
    ["invoke"] = "src/invoke.lua",
    ["lifecycle"] = "src/lifecycle.lua",
    ["reconcile"] = "src/reconcile.lua",
    ["registry"] = "src/registry.lua",
    ["helpers.createLeafNode"] = "src/helpers/createLeafNode.lua",
    ["helpers.getPrintableValue"] = "src/helpers/getPrintableValue.lua",
    ["utils.funcUtils"] = "src/utils/funcUtils.lua",
    ["utils.tableUtils"] = "src/utils/tableUtils.lua",
    ["components.mesh"] = "src/components/mesh.lua",
    ["components.text"] = "src/components/text.lua",
    ["components.shader"] = "src/components/shader.lua",
    ["propTypes.boolean"] = "src/propTypes/boolean.lua",
    ["propTypes.callable"] = "src/propTypes/callable.lua",
    ["propTypes.function"] = "src/propTypes/function.lua",
    ["propTypes.number"] = "src/propTypes/number.lua",
    ["propTypes.oneOf"] = "src/propTypes/oneOf.lua",
    ["propTypes.optional"] = "src/propTypes/optional.lua",
    ["propTypes.string"] = "src/propTypes/string.lua",
    ["propTypes.table"] = "src/propTypes/table.lua",
    ["propTypes.tableShape"] = "src/propTypes/tableShape.lua",
    ["propTypes.value"] = "src/propTypes/value.lua"
  }
}