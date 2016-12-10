local validateTable = require('src.validators.table')

describe('validateTable', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateTable('hi')
      end).to.fail()

      expect(function()
        validateTable(12)
      end).to.fail()

      expect(function()
        validateTable(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateTable({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateTable({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateTable({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value number', function()
      expect(function()
        validateTable({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateTable({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateTable({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'table'
    }

    it('returns true if the property is a table', function()
      expect(validateTable(propType, {}))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateTable(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateTable(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a number', function()
      expect(validateTable(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateTable(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateTable(propType, function() end))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'table'
    }

    it('returns true if the property is a table', function()
      expect(validateTable(propType, {}))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateTable(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateTable(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is nil', function()
      expect(validateTable(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateTable(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateTable(propType, function() end))
        .to.be(false)
    end)
  end)
end)