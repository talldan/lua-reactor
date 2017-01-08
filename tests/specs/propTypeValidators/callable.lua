local callable = require('src.propTypeValidators.callable')

describe('callable', function() 
  describe('behaviour', function()
    it('returns a function to use for validation', function()
      expect(type(callable()))
        .to.be('function')
    end)

    it('returns true when a function is passed to the validator', function()
      local callableValidator = callable()

      expect(callableValidator(function() end))
        .to.be(true)
    end)

    it('returns true when a callable table is passed to the validator', function()
      local callableValidator = callable()
      local callableTable = {}
      setmetatable(callableTable, {
        __call = function() end  
      })

      expect(callableValidator(callableTable))
        .to.be(true)
    end)

    it('returns false when a non-function is passed to the validator', function()
      local callableValidator = callable()

      expect(callableValidator('test'))
        .to.be(false)

      expect(callableValidator(12))
        .to.be(false)

      expect(callableValidator(nil))
        .to.be(false)
    end)

    it('returns false when a non-callable table is passed to the validator', function()
      local callableValidator = callable()
      
      expect(callableValidator({}))
        .to.be(false)
    end)
  end)
end)