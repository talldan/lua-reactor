local tableShape = require('src.propTypeValidators.tableShape')

local function trueValidator()
  return true 
end

local function falseValidator()
  return false 
end

describe('tableShape', function()
  describe('error states', function()
    it('causes an error is the table shape description is not expressed as a table', function()
      expect(function()
        tableShape()
      end).to.fail()

      expect(function()
        tableShape('test')
      end).to.fail()

      expect(function()
        tableShape(12)
      end).to.fail()

      expect(function()
        tableShape(true)
      end).to.fail()

      expect(function()
        tableShape(function() end)
      end).to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns false if a table is not specified to the validator', function()
      local validateEmptyTable = tableShape({})

      expect(validateEmptyTable())
        .to.be(false)

      expect(validateEmptyTable('test'))
        .to.be(false)

      expect(validateEmptyTable(12))
        .to.be(false)

      expect(validateEmptyTable(false))
        .to.be(false)

      expect(validateEmptyTable(function() end))
        .to.be(false)
    end)

    it('returns false if a table has a different number of keys to the validation description', function()
      local validateTable = tableShape({
        test = trueValidator
      })

      expect(validateTable({}))
        .to.be(false)

      expect(validateTable({1, 2}))
        .to.be(false)
    end)

    it('returns false if the specified keys in the able are named differently to the description', function()
      local validateTable = tableShape({
        test = trueValidator,
        anotherTest = trueValidator
      })

      expect(validateTable({ 
        test = 'hi',
        notAnotherTest = 2 
      })).to.be(false)

      expect(validateTable({ 
        notTest = 'hi',
        anotherTest = 2 
      })).to.be(false)
    end)

    it('returns false if any of the properties do not pass validation', function()
      local validateTable = tableShape({
        test = trueValidator,
        anotherTest = falseValidator
      })

      expect(validateTable({ 
        test = 'hi',
        anotherTest = 2 
      })).to.be(false)
    end)

    it('returns true when all properties pass validation', function()
      local validateTable = tableShape({
        test = trueValidator,
        anotherTest = trueValidator
      })

      expect(validateTable({ 
        test = 'hi',
        anotherTest = 2 
      })).to.be(true)
    end)

    it('matches an empty table correctly', function()
      local validateEmptyTable = tableShape({})

      expect(validateEmptyTable({}))
        .to.be(true)
    end)

    it('passes the property value to the property validator', function()
      local passedValue = nil
      local testValue = 'aloha'

      local validateTable = tableShape({
        test = function(value)
          passedValue = value
          return testValue == passedValue
        end
      })

      validateTable({
        test = testValue
      })

      expect(passedValue)
        .to.be(testValue)
    end)
  end)
end)