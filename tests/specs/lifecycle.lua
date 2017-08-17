local lifecycleModule = require('src.lifecycle')
local mockReactor = {
  registry = {
    getLastProps = function() end,
    mountComponentIfRequired = function() end
  }
}
local mockComponent = {
  name = 'mock',
  render = function(props)
    return function(path)
      return {
        props = props,
        path = path
      }
    end
  end
}
local lifecycle = lifecycleModule(mockReactor)

describe('#lifecycle', function()
  describe('behaviour', function()
    it('returns a function when called with a `component`', function()
      local component = {}

      expect(type(lifecycle(component)))
          .to.be('function')
    end)

    it('returns a function when called with a `component` and `props`', function()
      local component = {}
      local props = {}

      expect(type(lifecycle(component, props)))
          .to.be('function')
    end)

    it('returns a description of the rendered components when called with a `component`, `props`, and a `path`', function()
      local props = {
        test = 'test-value'
      }
      local path = ''

      local output = lifecycle(mockComponent, props, path)

      expect(output.path)
        .to.be('mock')

      expect(output.props.test)
        .to.be('test-value')
    end)
  end)
end)