local validateTable = require('src.propTypeValidators.table')

describe('table', function()
  describe('behaviour', function()
    it('returns a validator function to use for validation', function()
      expect(type(validateTable()))
        .to.be('function')
    end)

    it('returns true if the supplied value to the validator is of type table', function()
      local validator = validateTable()

      expect(validator({}))
        .to.be(true)
    end)

    it('returns false if the supplied value to the validator is of a type that is not a table', function()
      local validator = validateTable()

      expect(validator(nil))
        .to.be(false)

      expect(validator(true))
        .to.be(false)

      expect(validator(12))
        .to.be(false)

      expect(validator(function() end))
        .to.be(false)

      expect(validator('test'))
        .to.be(false)
    end)
  end)
end)