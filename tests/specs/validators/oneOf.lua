local validateOneOf = require('src.validators.oneOf')

describe('validateOneOf', function()
  describe('error states', function()
    it('causes an error if the first argument is not a table', function()
      expect(function()
        validateOneOf('hi')
      end).to.fail()

      expect(function()
        validateOneOf(12)
      end).to.fail()

      expect(function()
        validateOneOf(false)
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a boolean requied property', function()
      expect(function()
        validateOneOf({
          required = 'hi',
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = 12,
          propTypeName = 'string'  
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = {},
          propTypeName = 'string'  
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a propTypeName property with the value oneOf', function()
      expect(function()
        validateOneOf({
          required = true,
          propTypeName = 'dave'  
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = true,
          propTypeName = 12 
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = false,
          propTypeName = {'string'}
        })
      end).to.fail()
    end)

    it('causes an error if the first argument table does not have a validationData property that is a table with an array of values', function()
      expect(function()
        validateOneOf({
          required = true,
          propTypeName = 'oneOf'
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = true,
          propTypeName = 'oneOf',
          validationData = 'hi'
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = false,
          propTypeName = 'oneOf',
          validationData = {}
        })
      end).to.fail()

      expect(function()
        validateOneOf({
          required = false,
          propTypeName = 'oneOf',
          validationData = {
            hi = 'there'
          }
        })
      end).to.fail()
    end)
  end)

  describe('required == false', function()
    local propType = {
      required = false,
      propTypeName = 'oneOf',
      validationData = {'one', 'of'}
    }

    it('returns true if the property is a `one`', function()
      expect(validateOneOf(propType, 'one'))
        .to.be(true)
    end)

    it('returns true if the property is a `of`', function()
      expect(validateOneOf(propType, 'of'))
        .to.be(true)
    end)

    it('returns true if the property is nil', function()
      expect(validateOneOf(propType, nil))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateOneOf(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is a non-matching string', function()
      expect(validateOneOf(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateOneOf(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateOneOf(propType, function() end))
        .to.be(false)
    end)
  end)

  describe('required == true', function()
    local propType = {
      required = true,
      propTypeName = 'oneOf',
      validationData = {'one', 'of'}
    }

    it('returns true if the property is a `one`', function()
      expect(validateOneOf(propType, 'one'))
        .to.be(true)
    end)

    it('returns true if the property is a `of`', function()
      expect(validateOneOf(propType, 'of'))
        .to.be(true)
    end)

    it('returns false if the property is a number', function()
      expect(validateOneOf(propType, 12))
        .to.be(false)
    end)

    it('returns false if the property is nil', function()
      expect(validateOneOf(propType, nil))
        .to.be(false)
    end)

    it('returns false if the property is a string', function()
      expect(validateOneOf(propType, 'hi'))
        .to.be(false)
    end)

    it('returns false if the property is a table', function()
      expect(validateOneOf(propType, {}))
        .to.be(false)
    end)

    it('returns false if the property is a function', function()
      expect(validateOneOf(propType, function() end))
        .to.be(false)
    end)
  end)
end)