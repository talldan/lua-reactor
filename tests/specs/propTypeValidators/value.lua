local value = require('src.propTypeValidators.value')

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
    it('matches an exact value', function()
      local testValidator = value('test')

      expect(testValidator('test'))
        .to.be(true)

      expect(testValidator('notTest'))
        .to.be(false)

      expect(testValidator(4))
        .to.be(false)

      expect(testValidator(nil))
        .to.be(false)

      expect(testValidator(true))
        .to.be(false)

      local twelveValidator = value(12)

      expect(twelveValidator(12))
        .to.be(true)

      expect(twelveValidator('12'))
        .to.be(false)

      expect(twelveValidator(5))
        .to.be(false)

      expect(twelveValidator(nil))
        .to.be(false)

      expect(twelveValidator(true))
        .to.be(false)
    end)
  end)
end)