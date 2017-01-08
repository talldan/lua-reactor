local oneOf = require('src.propTypeValidators.oneOf')

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
  end)
end)