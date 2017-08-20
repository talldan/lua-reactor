local validateBoolean = require('reactor.propTypes.boolean')

describe('boolean', function()
  describe('behaviour', function()
    it('returns a validator function to use for validation', function()
      expect(type(validateBoolean()))
        .to.be('function')
    end)

    it('returns true if the supplied value to the validator is of type boolean', function()
      local validator = validateBoolean()

      expect(validator(true))
        .to.be(true)

      expect(validator(false))
        .to.be(true)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = validateBoolean()
      local isValid, reason = validator(true)

      expect(reason)
        .to.be(nil)
    end)

    it('returns false if the supplied value to the validator is of a type that is not a boolean', function()
      local validator = validateBoolean()

      expect(validator(nil))
        .to.be(false)

      expect(validator(12))
        .to.be(false)

      expect(validator('test'))
        .to.be(false)

      expect(validator(function() end))
        .to.be(false)

      expect(validator({}))
        .to.be(false)
    end)
    
    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = validateBoolean()
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)