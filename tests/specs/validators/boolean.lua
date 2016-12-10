local validateBoolean = require('src.validators.boolean')

describe('validateBoolean', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateBoolean('hi')
      end).to.fail()

      expect(function()
        validateBoolean(12)
      end).to.fail()

      expect(function()
        validateBoolean(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateBoolean({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateBoolean({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateBoolean({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value number', function()
      expect(function()
        validateBoolean({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateBoolean({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateBoolean({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'boolean'
    }

    it('returns true if the property is a boolean', function()
      expect(validateBoolean(propType, true))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateBoolean(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateBoolean(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateBoolean(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateBoolean(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateBoolean(propType, function() end))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'boolean'
    }

    it('returns true if the property is a boolean', function()
      expect(validateBoolean(propType, true))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateBoolean(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is nil', function()
      expect(validateBoolean(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateBoolean(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateBoolean(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateBoolean(propType, function() end))
        .to.be(false)
    end)
  end)
end)