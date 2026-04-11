---@meta

---@class luassert.Stub : luassert.Spy
local stub = {}

---Effectively unstub a function.
---@return any old_elem -- the original value it stubbed
function stub:revert() end

---Return these values when called.
---@param ... unknown
---@return self
function stub.returns(...) end

---Call this function and use its return values when called.
---@param func function
---@return self
function stub.invokes(func) end

---@type luassert.Stub.call_interface
stub.by_default = nil

---@class luassert.Stub.call_interface
---Return these values when called.
---@field returns fun(...: unknown): luassert.Stub
---Call this function and use its return values when called.
---@field invokes fun(func: function): luassert.Stub

---Return an interface that allows changing stub behavior when given
---@return luassert.Stub.call_interface
function stub.on_call_with(...) end

---Function similarly to spies, except that stubs do not call the function that they replace.
---@class luassert.stub_factory
---@overload fun(object: table, key: unknown, fn: function): (stub: luassert.Stub)
---@overload fun(object: table, key: unknown, ...: any): (stub: luassert.Stub)
local stub_factory = {}

---Create a new stub that replaces a method in a table in-place.
---@param object table -- the object that the method is in
---@param key unknown -- the key of the method in the `object` to replace
---@param ... any -- a function that operates on the remaining passed in values and returns more values or just values to return
---@return luassert.Stub stub -- a stub object that can be used to perform assertions
---@return any ... -- values returned by a passed in function or just the values passed in
---@overload fun(object: table, key: unknown, fn: function): (stub: luassert.Stub)
function stub_factory(object, key, ...) end

---Creates a new stub that replaces a method in a table in place.
---@param object table -- The object that the method is in
---@param key string -- The key of the method in the `object` to replace
---@param ... any -- A function that operates on the remaining passed in values and returns more values or just values to return
---@return luassert.Stub stub -- A stub object that can be used to perform assertions
---@return any ... -- Values returned by a passed in function or just the values passed in
---
---## Example
---```
---describe("Stubs", function()
---    local t = {
---        lottery = function(...)
---            print("Your numbers: " .. table.concat({ ... }, ","))
---        end,
---    }
---
---    it("Tests stubs", function()
---        local myStub = stub.new(t, "lottery")
---
---        t.lottery(1, 2, 3) -- does not print
---        t.lottery(4, 5, 6) -- does not print
---
---        assert.stub(myStub).called_with(1, 2, 3)
---        assert.stub(myStub).called_with(4, 5, 6)
---        assert.stub(myStub).called(2)
---        assert.stub(myStub).called_less_than(3)
---
---        myStub:revert()
---
---        t.lottery(10, 11, 12) -- prints
---    end)
---end)
---```
function stub_factory.new(object, key, ...) end

return stub_factory
