local validateNumber = require('reactor.propTypes.number')

describe('number', function()
  describe('behaviour', function()
    it('returns a validator function to use for validation', function()
      expect(type(validateNumber()))
        .to.be('function')
    end)

    it('returns true if the supplied value to the validator is of type number', function()
      local validator = validateNumber()

      expect(validator(12))
        .to.be(true)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = validateNumber()
      local isValid, reason = validator(12)

      expect(reason)
        .to.be(nil)
    end)

    it('returns false if the supplied value to the validator is of a type that is not a number', function()
      local validator = validateNumber()

      expect(validator(nil))
        .to.be(false)

      expect(validator(true))
        .to.be(false)

      expect(validator('test'))
        .to.be(false)

      expect(validator(function() end))
        .to.be(false)

      expect(validator({}))
        .to.be(false)
    end)
    
    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = validateNumber()
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)