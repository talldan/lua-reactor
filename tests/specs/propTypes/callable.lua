local callable = require('src.propTypes.callable')

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

    it('does not return a second return value when validating a function is successful', function()
      local validator = callable()
      local isValid, reason = validator(function() end)

      expect(reason)
        .to.be(nil)
    end)

    it('does not return a second return value when validating a callable table is successful', function()
      local validator = callable()
      local callableTable = {}
      setmetatable(callableTable, {
        __call = function() end  
      })
      local isValid, reason = validator(callableTable)

      expect(reason)
        .to.be(nil)
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
    
    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = callable()
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)