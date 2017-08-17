local componentModule = require('component')
local lifecycleModule = require('lifecycle')
local registryModule = require('registry')
local reconcileModule = require('reconcile')
local invokeModule = require('invoke')
local drawModule = require('draw')

local reactor = {}

reactor.registry = registryModule(reactor)
reactor.component = componentModule(reactor)
reactor.lifecycle = lifecycleModule(reactor)
reactor.reconcile = reconcileModule(reactor)
reactor.invoke = invokeModule(reactor)
reactor.draw = drawModule(reactor)

return reactor
