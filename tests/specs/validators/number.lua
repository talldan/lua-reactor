local validateNumber = require('src.validators.number')

describe('validateNumber', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateNumber('hi')
      end).to.fail()

      expect(function()
        validateNumber(12)
      end).to.fail()

      expect(function()
        validateNumber(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateNumber({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateNumber({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateNumber({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value number', function()
      expect(function()
        validateNumber({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateNumber({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateNumber({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'number'
    }

    it('returns true if the property is a number', function()
      expect(validateNumber(propType, 12))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateNumber(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a string', function()
      expect(validateNumber(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateNumber(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateNumber(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateNumber(propType, function() end))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'number'
    }

    it('returns true if the property is a number', function()
      expect(validateNumber(propType, 12))
        .to.be(true)
    end)

    it('returns false if the property is nil', function()
      expect(validateNumber(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateNumber(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateNumber(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateNumber(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateNumber(propType, function() end))
        .to.be(false)
    end)
  end)
end)