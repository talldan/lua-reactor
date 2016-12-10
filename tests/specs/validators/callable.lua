local validateCallable = require('src.validators.callable')

describe('validateCallable', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateCallable('hi')
      end).to.fail()

      expect(function()
        validateCallable(12)
      end).to.fail()

      expect(function()
        validateCallable(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateCallable({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateCallable({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateCallable({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value number', function()
      expect(function()
        validateCallable({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateCallable({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateCallable({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'callable'
    }

    it('returns true if the property is a function', function()
      expect(validateCallable(propType, function() end))
        .to.be(true)
    end)

    it('returns true if the property is a table with a __call metatable property', function()
      local tbl = {}
      setmetatable(tbl, {
        __call = function() end  
      })

      expect(validateCallable(propType, tbl))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateCallable(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateCallable(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is a number', function()
      expect(validateCallable(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateCallable(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateCallable(propType, {}))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'callable'
    }

    it('returns true if the property is a function', function()
      expect(validateCallable(propType, function() end))
        .to.be(true)
    end)

    it('returns true if the property is a table with a __call metatable property', function()
      local tbl = {}
      setmetatable(tbl, {
        __call = function() end  
      })

      expect(validateCallable(propType, tbl))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateCallable(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a boolean', function()
      expect(validateCallable(propType, true))
        .to.be(false)
    end)

    it('returns false if the property is nil', function()
      expect(validateCallable(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateCallable(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateCallable(propType, {}))
        .to.be(false)
    end)
  end)
end)