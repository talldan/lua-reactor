local declare = require('src.declare')

describe('declare', function()
  describe('error states', function()
    it('causes an error if the first argument is not a function', function()
      expect(function()
        declare('a string')
      end).to.fail()

      expect(function()
        declare(12)
      end).to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns a function when passed a function for the first argument', function()
      expect(type(declare(function() end)))
        .to.be('function')
    end)

    it('returns a function that calls through to the first argument function', function()
      local callCount = 0
      local declared = declare(function()
        callCount = callCount + 1
      end)

      declared()

      expect(callCount)
        .to.be(1)
    end)
  end)
end)