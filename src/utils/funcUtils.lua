local tableUtils = require('utils.tableUtils')
local reduce = tableUtils.reduce
local concat = tableUtils.concat
local map = tableUtils.map
local curryPlaceholder = {}

local function compose(originalSource, ...)
  return reduce(function(func, _, source)
    return func(source)
  end, originalSource, {...})
end

local function replacePlaceholder(args)
  return map(function(value)
    if value == curryPlaceholder then
      return nil
    else
      return value
    end
  end, args)
end

local function curry(func, requiredArity, previousArgs)
  return function(...)
    previousArgs = previousArgs or {}
    local newArgs

    if ... then
      newArgs = {...}
    else
      newArgs = {curryPlaceholder}
    end

    local arguments = concat(previousArgs, newArgs)
    local arity = #arguments

    if arity >= requiredArity then
      local args = replacePlaceholder(arguments)
      return func(unpack(args, 1, table.maxn(args)))
    else
      return curry(func, requiredArity, arguments)
    end
  end
end

return {
  compose = compose,
  curry = curry
}