local optional = require('reactor.propTypes.optional')

local function stringValidator()
  return function(toValidate)
    local isValid = type(toValidate) == 'string'
    local reason = nil

    if not isValid then
      reason = 'not a string'
    end

    return isValid, reason
  end
end

describe('optional', function()
  describe('error states', function()
    it('causes an error if the argument to optional is not a function', function()
      expect(function()
        optional()
      end).to.fail()

      expect(function()
        optional('test')
      end).to.fail()

      expect(function()
        optional(12)
      end).to.fail()

      expect(function()
        optional(true)
      end).to.fail()

      expect(function()
        optional({})
      end).to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns a function to use for validation when passed a function to wrap', function()
      expect(type(optional(stringValidator())))
        .to.be('function')
    end)

    it('allows nil as an accepted value when wrapping another validator', function()
      local validateString = stringValidator()
      local optionalValidateString = optional(stringValidator())

      expect(validateString('test'))
        .to.be(true)

      expect(validateString(nil))
        .to.be(false)

      expect(validateString(12))
        .to.be(false)

      expect(optionalValidateString('test'))
        .to.be(true)

      expect(optionalValidateString(nil))
        .to.be(true)

      expect(optionalValidateString(12))
        .to.be(false)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = optional(stringValidator())
      local isValid, reason = validator()

      expect(reason)
        .to.be(nil)
    end)


    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = optional(stringValidator())
      local isValid, reason = validator(12)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)