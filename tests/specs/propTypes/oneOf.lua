local oneOf = require('src.propTypes.oneOf')

local function trueValidator()
  return true 
end

local function falseValidator()
  return false 
end

describe('oneOf', function()
  describe('error states', function()
    it('causes an error if the description passed in not of type table', function()
      expect(function()
        oneOf()
      end).to.fail()

      expect(function()
        oneOf('test')
      end).to.fail()

      expect(function()
        oneOf(12)
      end).to.fail()

      expect(function()
        oneOf(function() end)
      end).to.fail()

      expect(function()
        oneOf(false)
      end).to.fail()
    end)
  end)

  describe('behaviour', function() 
    it('returns a function to use for validation when passed a valid description', function()
      expect(type(oneOf({trueValidator, falseValidator})))
        .to.be('function')
    end)

    it('returns false if all validators specified in the description return false', function()
      local validator = oneOf({
        falseValidator,
        falseValidator
      })

      expect(validator())
        .to.be(false)
    end)

    it('returns true if a single validator specified in the description return true', function()
      local validator = oneOf({
        falseValidator,
        trueValidator
      })

      expect(validator())
        .to.be(true)
    end)

    it('returns true if a all validators specified in the description return true', function()
      local validator = oneOf({
        trueValidator,
        trueValidator
      })

      expect(validator())
        .to.be(true)
    end)

    it('does not return a second return value when validation is successful', function()
      local validator = oneOf({
        trueValidator,
        trueValidator
      })
      local isValid, reason = validator()

      expect(reason)
        .to.be(nil)
    end)


    it('returns a second return value of type string that represents the reason validation failed', function()
      local validator = oneOf({
        falseValidator,
        falseValidator
      })
      local isValid, reason = validator(nil)

      expect(type(reason))
        .to.be('string')
    end)
  end)
end)