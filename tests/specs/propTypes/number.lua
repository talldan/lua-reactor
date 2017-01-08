local validateNumber = require('src.propTypes.number')

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
  end)
end)