local propTypes = require('src.propTypes')

function testEach(table, func)
  for key, item in pairs(table) do
    func(key, item)
  end
end

function testEachOf(keys, table, func)
  for index, key in ipairs(keys) do
    local item = table[key]
    if item ~= nil then
      func(key, item)
    end
  end 
end

describe('propTypes', function()
  it('should be a table', function()
    expect(type(propTypes))
      .to.be('table')
  end)

  testEach(propTypes, function(key, propType)
    describe(key, function()
      it('should contain an isRequired property that is a table', function()
        expect(type(propType.isRequired))
          .to.be('table')
      end)

      it('should contain a required property that is a boolean on the root-level table', function()
        expect(type(propType.required))
          .to.be('boolean')
      end)

      it('should contain a required property that is a boolean on the isRequired table', function()
        expect(type(propType.isRequired.required))
          .to.be('boolean')
      end)

      it('should contain a required property that is false on the root-level table', function()
        expect(propType.required)
          .to.be(false)
      end)

      it('should contain a required property that is true on the isRequired table', function()
        expect(propType.isRequired.required)
          .to.be(true)
      end)

      it('should have a key that matches propTypeName property on the root-level table', function()
        expect(key)
          .to.be(propType.propTypeName)
      end)

      it('should have a key that matches propTypeName property on the isRequired table', function()
        expect(key)
          .to.be(propType.isRequired.propTypeName)
      end)
    end)
  end)

  testEachOf({'shape', 'listOf', 'oneOf', 'oneOfType'}, propTypes, function(key, propType)
    describe('callable aspects of propType ' .. key, function()
      it('should not cause an error when called', function()
        expect(function()
          propType()
        end).to_not.fail()
      end)

      it('should return a new propType that is not the same instance as the original', function()
        local newPropType = propType()
        expect(newPropType)
          .to_not.be(propType)
      end)

      it('should return a propType that is not callable a second time', function()
        expect(function()
          local newPropType = propType()
          newPropType()
        end).to.fail()
      end)

      it('should return a proptype with the same name as the original', function()
        local newPropType = propType()
        expect(newPropType.name)
          .to.be(propType.name)
      end)

      it('should return a propType with a data property set to the value of the first argument', function()
        local testArgument = "a test argument"
        local newPropType = propType(testArgument)

        expect(newPropType.data)
          .to.be(testArgument)
      end)

    end)
  end)
end)
