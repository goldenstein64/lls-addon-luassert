---@meta

---@alias luassert.Mock { [unknown]: luassert.Mock | luassert.Spy }

---A mock wraps an entire table's functions in spies or mocks.
---@class luassert.mock.factory : luassert.spy.factory
---@overload fun(object: unknown, doStubs?: boolean, func?: function, self?: table, key?: unknown): luassert.Mock
local mock = {}

---Create a new mock from a table, recursively wrapping all of its functions in
---spies or mocks.
---@param object unknown -- the table to wrap
---@param doStubs? boolean -- if the table should be wrapped with stubs instead of spies
---@param func? function -- callback function used for stubs
---@param self? table -- table to replace with a spy
---@param key? unknown -- the key of the method to replace in `self`
---@return luassert.Mock
function mock(object, doStubs, func, self, key) end

---Create a new mock from a table, recursively wrapping all of its functions in
---spies or mocks.
---@param object unknown -- the table to wrap
---@param doStubs? boolean -- if the table should be wrapped with stubs instead of spies
---@param func? function -- callback function used for stubs
---@param self? table -- table to replace with a spy
---@param key? unknown -- the key of the method to replace in `self`
---@return luassert.Mock
function mock.new(object, doStubs, func, self, key) end

---Clear call history from all spies and stubs created in this mock.
---@param object luassert.Mock -- the wrapped table
---@return luassert.Mock object -- the same object with call history cleared
function mock.clear(object) end

---Remove all spies and stubs in this mock.
---@param object luassert.Mock -- the wrapped table
---@return any object -- the same object without spies or stubs
function mock.revert(object) end

return mock
