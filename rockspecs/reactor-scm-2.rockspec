package = "reactor"
version = "scm-2"
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
    ["reactor.init"] = "src/reactor/init.lua",
    ["reactor.component"] = "src/reactor/component.lua",
    ["reactor.draw"] = "src/reactor/draw.lua",
    ["reactor.invoke"] = "src/reactor/invoke.lua",
    ["reactor.lifecycle"] = "src/reactor/lifecycle.lua",
    ["reactor.reconcile"] = "src/reactor/reconcile.lua",
    ["reactor.registry"] = "src/reactor/registry.lua",
    ["reactor.helpers.createLeafNode"] = "src/reactor/helpers/createLeafNode.lua",
    ["reactor.helpers.getPrintableValue"] = "src/reactor/helpers/getPrintableValue.lua",
    ["reactor.utils.funcUtils"] = "src/reactor/utils/funcUtils.lua",
    ["reactor.utils.tableUtils"] = "src/reactor/utils/tableUtils.lua",
    ["reactor.components.mesh"] = "src/reactor/components/mesh.lua",
    ["reactor.components.text"] = "src/reactor/components/text.lua",
    ["reactor.components.shader"] = "src/reactor/components/shader.lua",
    ["reactor.propTypes.boolean"] = "src/reactor/propTypes/boolean.lua",
    ["reactor.propTypes.callable"] = "src/reactor/propTypes/callable.lua",
    ["reactor.propTypes.function"] = "src/reactor/propTypes/function.lua",
    ["reactor.propTypes.number"] = "src/reactor/propTypes/number.lua",
    ["reactor.propTypes.oneOf"] = "src/reactor/propTypes/oneOf.lua",
    ["reactor.propTypes.optional"] = "src/reactor/propTypes/optional.lua",
    ["reactor.propTypes.string"] = "src/reactor/propTypes/string.lua",
    ["reactor.propTypes.table"] = "src/reactor/propTypes/table.lua",
    ["reactor.propTypes.tableShape"] = "src/reactor/propTypes/tableShape.lua",
    ["reactor.propTypes.value"] = "src/reactor/propTypes/value.lua"
  }
}