local validateString = require('src.validators.string')

describe('validateString', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateString('hi')
      end).to.fail()

      expect(function()
        validateString(12)
      end).to.fail()

      expect(function()
        validateString(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateString({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateString({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateString({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value string', function()
      expect(function()
        validateString({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateString({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateString({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'string'
    }

    it('returns true if the property is a string', function()
      expect(validateString(propType, 'hi'))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateString(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateString(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateString(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateString(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateString(propType, function() end))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'string'
    }

    it('returns true if the property is a string', function()
      expect(validateString(propType, 'hi'))
        .to.be(true)
    end)

    it('returns false if the property is nil', function()
      expect(validateString(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a number', function()
      expect(validateString(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateString(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateString(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateString(propType, function() end))
        .to.be(false)
    end)
  end)
end)