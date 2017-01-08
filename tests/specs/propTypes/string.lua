local validateString = require('src.propTypes.string')

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

    it('does not return a second return value when validation is successful', function()
      local validator = validateString()
      local isValid, reason = validator('test')

      expect(reason)
        .to.be(nil)
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

    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = validateString()
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)