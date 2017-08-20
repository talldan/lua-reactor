package.path = './src/?.lua;./src/?/init.lua;' .. package.path

return {
  'tests/specs/reactor/reconcile.lua',
  'tests/specs/reactor/lifecycle.lua',
  'tests/specs/reactor/component.lua',
  'tests/specs/reactor/invoke.lua',
  'tests/specs/reactor/propTypes/tableShape.lua',
  'tests/specs/reactor/propTypes/optional.lua',
  'tests/specs/reactor/propTypes/value.lua',
  'tests/specs/reactor/propTypes/boolean.lua',
  'tests/specs/reactor/propTypes/callable.lua',
  'tests/specs/reactor/propTypes/function.lua',
  'tests/specs/reactor/propTypes/number.lua',
  'tests/specs/reactor/propTypes/string.lua',
  'tests/specs/reactor/propTypes/table.lua',
  'tests/specs/reactor/propTypes/oneOf.lua'
}