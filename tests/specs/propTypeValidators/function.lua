local validateFunction = require('src.propTypeValidators.function')

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
  end)
end)