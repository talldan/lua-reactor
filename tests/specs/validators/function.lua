local validateFunction = require('src.validators.function')

describe('validateFunction', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateFunction('hi')
      end).to.fail()

      expect(function()
        validateFunction(12)
      end).to.fail()

      expect(function()
        validateFunction(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateFunction({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateFunction({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateFunction({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value number', function()
      expect(function()
        validateFunction({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateFunction({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateFunction({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'function'
    }

    it('returns true if the property is a function', function()
      expect(validateFunction(propType, function() end))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateFunction(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateFunction(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a number', function()
      expect(validateFunction(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateFunction(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateFunction(propType, {}))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'function'
    }

    it('returns true if the property is a function', function()
      expect(validateFunction(propType, function() end))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateFunction(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateFunction(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is nil', function()
      expect(validateFunction(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateFunction(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateFunction(propType, {}))
        .to.be(false)
    end)
  end)
end)