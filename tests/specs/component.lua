local componentModule = require('src.component')
local expectedLifecycle = 'test-lifecycle'
local mockReactor = {
  lifecycle = function()
    return expectedLifecycle
  end
}
local component = componentModule(mockReactor)

describe('#component', function()
  describe('errors', function()
    it('causes an error if the component definition does not have a `name` property', function()
      local componentWithoutName = {
        render = function() end
      }

      expect(function() component(componentWithoutName) end)
        .to.fail()
    end)

    it('causes an error if the component definition does not have a `render` property', function()
      local componentWithoutRender = {
        name = 'test'
      }

      expect(function() component(componentWithoutRender) end)
        .to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns the result of the lifecycle function', function()
      local output = component{
        name = 'test',
        render = function() end
      }

      expect(output)
        .to.be(expectedLifecycle)
    end)
  end)
end)