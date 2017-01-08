local validateString = require('src.propTypeValidators.string')

describe('string', function()
  describe('behaviour', function()
    it('returns a validator function to use for validation', function()
      expect(type(validateString()))
        .to.be('function')
    end)

    it('returns true if the supplied value to the validator is of type string', function()
      local validator = validateString()

      expect(validator('test'))
        .to.be(true)
    end)

    it('returns false if the supplied value to the validator is of a type that is not a string', function()
      local validator = validateString()

      expect(validator(nil))
        .to.be(false)

      expect(validator(true))
        .to.be(false)

      expect(validator(12))
        .to.be(false)

      expect(validator(function() end))
        .to.be(false)

      expect(validator({}))
        .to.be(false)
    end)
  end)
end)