local componentModule = require('reactor.component')
local lifecycleModule = require('reactor.lifecycle')
local registryModule = require('reactor.registry')
local reconcileModule = require('reactor.reconcile')
local invokeModule = require('reactor.invoke')
local drawModule = require('reactor.draw')

local reactor = {}

reactor.registry = registryModule(reactor)
reactor.component = componentModule(reactor)
reactor.lifecycle = lifecycleModule(reactor)
reactor.reconcile = reconcileModule(reactor)
reactor.invoke = invokeModule(reactor)
reactor.draw = drawModule(reactor)

return reactor
