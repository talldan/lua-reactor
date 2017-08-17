local invokeModule = require('src.invoke')

local invoke = invokeModule()

describe('invoke', function()
  describe('create operation type', function()
    local expectedProps = {}
    local operations = {
      {
        operationType = 'create',
        create = function() end,
        update = function() end,
        draw = function() end,
        props = expectedProps
      }
    }

    it('calls the create, update and draw functions in the operation with the props', function()
      local operation = operations[1]
      local createSpy = spy(operation, 'create')
      local updateSpy = spy(operation, 'update')
      local drawSpy = spy(operation, 'draw')

      invoke(operations)

      expect(#createSpy)
        .to.be(1)
      expect(createSpy[1][1])
        .to.be(expectedProps)

      expect(#updateSpy)
        .to.be(1)
      expect(updateSpy[1][2])
        .to.be(expectedProps)

      expect(#drawSpy)
        .to.be(1)
      expect(drawSpy[1][1])
        .to.be(expectedProps)
    end)
  end)

  describe('update operation type', function()
    local expectedProps = {}
    local operations = {
      {
        operationType = 'update',
        update = function() end,
        draw = function() end,
        props = expectedProps
      }
    }

    it('calls the update and draw functions in the operation with the props', function()
      local operation = operations[1]
      local updateSpy = spy(operation, 'update')
      local drawSpy = spy(operation, 'draw')

      invoke(operations)

      expect(#updateSpy)
        .to.be(1)
      expect(updateSpy[1][2])
        .to.be(expectedProps)

      expect(#drawSpy)
        .to.be(1)
      expect(drawSpy[1][1])
        .to.be(expectedProps)
    end)
  end)

  describe('delete operation type', function()
    local expectedProps = {}
    local operations = {
      {
        operationType = 'delete',
        delete = function() end,
        props = expectedProps
      }
    }

    it('calls the update and draw functions in the operation with the props', function()
      local operation = operations[1]
      local deleteSpy = spy(operation, 'delete')

      invoke(operations)

      expect(#deleteSpy)
        .to.be(1)
      expect(deleteSpy[1][1])
        .to.be(expectedProps)
    end)
  end)

  describe('postChildUpdate operation type', function()
    local expectedProps = {}
    local operations = {
      {
        operationType = 'postChildUpdate',
        postChildUpdate = function() end,
        props = expectedProps
      }
    }

    it('calls the update and draw functions in the operation with the props', function()
      local operation = operations[1]
      local postChildUpdateSpy = spy(operation, 'postChildUpdate')

      invoke(operations)

      expect(#postChildUpdateSpy)
        .to.be(1)
      expect(postChildUpdateSpy[1][1])
        .to.be(expectedProps)
    end)
  end)
end)