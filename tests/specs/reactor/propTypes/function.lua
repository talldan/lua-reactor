local validateFunction = require('reactor.propTypes.function')

describe('function', function() 
  describe('behaviour', function()
    it('returns a function to use for validation', function()
      expect(type(validateFunction()))
        .to.be('function')
    end)

    it('returns true when a function is passed to the validator', function()
      local functionValidator = validateFunction()

      expect(functionValidator(function() end))
        .to.be(true)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = validateFunction()
      local isValid, reason = validator(function() end)

      expect(reason)
        .to.be(nil)
    end)

    it('returns false when a non-function is passed to the validator', function()
      local functionValidator = validateFunction()

      expect(functionValidator('test'))
        .to.be(false)

      expect(functionValidator(12))
        .to.be(false)

      expect(functionValidator(nil))
        .to.be(false)

      expect(functionValidator({}))
        .to.be(false)
    end)
    
    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = validateFunction()
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)