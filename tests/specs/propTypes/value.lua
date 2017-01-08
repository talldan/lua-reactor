local value = require('src.propTypes.value')

describe('value', function()
  describe('error states', function()
    it('causes an error when passed nil as the argument', function()
      expect(function()
        value()
      end).to.fail()

      expect(function()
        value(nil)
      end).to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns a function to use for validation when passed a valid description', function()
      expect(type(value({trueValidator, falseValidator})))
        .to.be('function')
    end)

    it('returns true when an exact value is matched', function()
      local testValidator = value('test')

      expect(testValidator('test'))
        .to.be(true)

      local twelveValidator = value(12)

      expect(twelveValidator(12))
        .to.be(true)
    end)

    it('returns false when a value is not matched', function()
      local testValidator = value('test')

      expect(testValidator('notTest'))
        .to.be(false)

      expect(testValidator(4))
        .to.be(false)

      expect(testValidator(nil))
        .to.be(false)

      expect(testValidator(true))
        .to.be(false)

      expect(testValidator(function() end))
        .to.be(false)

      expect(testValidator({}))
        .to.be(false)

      local twelveValidator = value(12)

      expect(twelveValidator('12'))
        .to.be(false)

      expect(twelveValidator(5))
        .to.be(false)

      expect(twelveValidator(nil))
        .to.be(false)

      expect(twelveValidator(true))
        .to.be(false)

      expect(twelveValidator(function() end))
        .to.be(false)

      expect(twelveValidator({}))
        .to.be(false)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = value('test')
      local isValid, reason = validator('test')

      expect(reason)
        .to.be(nil)
    end)

    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = value('test')
      local isValid, reason = validator(true)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)