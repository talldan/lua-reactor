# lua-reactor
React-style ui component system for Lua

Currently can render a few primitives (text, meshes, and shaders) using love2d

More components coming soon ...

### TODO
- Continous integration
- Component unmounting
- PropType validation
- Context
- More component types
- More tests
- Extract things like PropTypes and components into separate modules

### Declare a component
```
local component = require('reactor').component
local text = require('components.text')

return component{
  name = 'helloText',
  render = function(props)
    return text{
      value = 'Hello, ' .. props.name,
      x = 0,
      y = 0,
      width = 100
    }
  end
}
```

### Draw components
```
local helloText = require('helloText')
local draw = require('reactor').draw

draw(helloText{
  name = 'World!'
})
```

### The render function can return arrays of components
```
local helloText = require('helloText')
local component = require('reactor').component
local map = require('map')

return component{
  name = 'helloMessages',
  render = function(props)
    local helloMessages = map(props.names, function(name)
      return helloText({
        name = name
      })
    end)
    return helloMessages
  end
}
```