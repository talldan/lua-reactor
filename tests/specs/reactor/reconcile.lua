local reconcileModule = require('reactor.reconcile')
local reconcile = reconcileModule()

describe('#reconcile', function()
  describe('errors', function()
    it('throws an error when called without a table as the first argument', function()
      expect(function() reconcile(nil) end)
        .to.fail()

      expect(function() reconcile(1) end)
        .to.fail()

      expect(function() reconcile('a') end)
        .to.fail()

      expect(function() reconcile(false) end)
        .to.fail()
    end)

    it('throws an error when called without a table or nil as the second argument', function()
      expect(function() reconcile(1) end)
        .to.fail()

      expect(function() reconcile('a') end)
        .to.fail()

      expect(function() reconcile(false) end)
        .to.fail()
    end)
  end)

  describe('behaviour', function()
    it('returns an empty object describing the operations when called with an empty object', function()
      expect(reconcile({}))
        .to.equal({})
    end)

    describe('shallow comparison', function()
      it('returns an object with a single `create` entry when given the appropriate description on its own', function()
        local description = {
          props = {},
          name = "test",
          path = 'test'
        }

        local operations = reconcile(description)

        expect(#operations)
          .to.be(1)

        expect(operations[1].path)
          .to.be('test')

        expect(operations[1].operationType)
          .to.be('create')
      end)

      it('returns an object with a single `create` entry when given the appropriate description in a collection', function()
        local description = {
          {
            props = {},
            name = "test",
            path = "1.test"
          }
        }

        local operations = reconcile(description)

        expect(#operations)
          .to.be(1)

        expect(operations[1].path)
          .to.be('1.test')

        expect(operations[1].operationType)
          .to.be('create')
      end)

      it('returns an object with a two `create` entries when given the appropriate description', function()
        local description = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            props = {},
            name = "test_2",
            path = "2.test_2"
          }
        }

        local operations = reconcile(description)

        expect(#operations)
          .to.be(2)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('create')

        expect(operations[2].path)
          .to.be('2.test_2')
        expect(operations[2].operationType)
          .to.be('create')
      end)

      it('returns an object with a two `update` entries when given the appropriate description', function()
        local description = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            props = {},
            name = "test_2",
            path = "2.test_2"
          }
        }

        local operations = reconcile(description, description)

        expect(#operations)
          .to.be(2)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('update')

        expect(operations[2].path)
          .to.be('2.test_2')
        expect(operations[2].operationType)
          .to.be('update')
      end)

      it('returns an object with a two `delete` entries when given the appropriate description', function()
        local description = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            props = {},
            name = "test_2",
            path = "2.test_2"
          }
        }

        local operations = reconcile({}, description)

        expect(#operations)
          .to.be(2)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('delete')

        expect(operations[2].path)
          .to.be('2.test_2')
        expect(operations[2].operationType)
          .to.be('delete')
      end)
    end)

    describe('deep comparison', function()
      it('returns an object with a four `create` entries when given the appropriate descriptions', function()
        local description = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            {
              props = {},
              name = "test_2",
              path = "2.1.test_2"
            }
          },
          {
            {
              {
                props = {},
                name = "test_3",
                path = "3.1.1.test_3"
              },
              {
                props = {},
                name = "test_4",
                path = "3.1.2.test_4"
              }
            }
          }
        }

        local operations = reconcile(description)

        expect(#operations)
          .to.be(4)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('create')

        expect(operations[2].path)
          .to.be('2.1.test_2')
        expect(operations[2].operationType)
          .to.be('create')

        expect(operations[3].path)
          .to.be('3.1.1.test_3')
        expect(operations[3].operationType)
          .to.be('create')

        expect(operations[4].path)
          .to.be('3.1.2.test_4')
        expect(operations[4].operationType)
          .to.be('create')
      end)

      it('returns an object with a two `create`, two `update` and two `delete` entries when given the appropriate descriptions', function()
        local currentDescription = {
          {
            props = {},
            path = "1.test_1",
            name = "test_1"
          },
          {
            {
              props = {},
              path = "2.1.test_5",
              name = "test_5"
            }
          },
          {
            {
              {
                props = {},
                path = "3.1.1.test_3",
                name = "test_3"
              },
              {
                props = {},
                path = "3.1.2.test_6",
                name = "test_6"
              }
            }
          }
        }

        local lastDescription = {
          {
            props = {},
            path = "1.test_1",
            name = "test_1"
          },
          {
            {
              props = {},
              path = "2.1.test_2",
              name = "test_2"
            }
          },
          {
            {
              {
                props = {},
                path = "3.1.1.test_3",
                name = "test_3"
              },
              {
                props = {},
                path = "3.1.2.test_4",
                name = "test_4"
              }
            }
          }
        }

        local operations = reconcile(currentDescription, lastDescription)

        expect(#operations)
          .to.be(6)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('update')

        expect(operations[2].path)
          .to.be('2.1.test_2')
        expect(operations[2].operationType)
          .to.be('delete')

        expect(operations[3].path)
          .to.be('2.1.test_5')
        expect(operations[3].operationType)
          .to.be('create')

        expect(operations[4].path)
          .to.be('3.1.1.test_3')
        expect(operations[4].operationType)
          .to.be('update')

        expect(operations[5].path)
          .to.be('3.1.2.test_4')
        expect(operations[5].operationType)
          .to.be('delete')

        expect(operations[6].path)
          .to.be('3.1.2.test_6')
        expect(operations[6].operationType)
          .to.be('create')
      end)

      it('returns an object with a one `create`, one `update` and one `delete` entries when given the appropriate descriptions', function()
        local currentDescription = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            {
              props = {},
              name = "test_3",
              path = "2.1.test_3"
            }
          }
        }

        local lastDescription = {
          {
            props = {},
            name = "test_1",
            path = "1.test_1"
          },
          {
            props = {},
            name = "test_2",
            path = "2.test_2"
          }
        }

        local operations = reconcile(currentDescription, lastDescription)

        expect(#operations)
          .to.be(3)

        expect(operations[1].path)
          .to.be('1.test_1')
        expect(operations[1].operationType)
          .to.be('update')

        expect(operations[2].path)
          .to.be('2.test_2')
        expect(operations[2].operationType)
          .to.be('delete')

        expect(operations[3].path)
          .to.be('2.1.test_3')
        expect(operations[3].operationType)
          .to.be('create')
      end)
    end)
  end)
end)