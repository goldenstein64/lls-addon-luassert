---@meta

---Spies allow you to wrap a function in order to track how that function was
---called.
---@class luassert.spy.factory
---
---## Example
---
---```
---describe("New Spy", function()
---    it("Registers a new function to spy on", function()
---        local s = spy.new(function() end)
---
---        s(1, 2, 3)
---        s(4, 5, 6)
---
---        assert.spy(s).was.called()
---        assert.spy(s).was.called(2)
---        assert.spy(s).was.called_with(1, 2, 3)
---    end)
---end)
---```
---@overload fun(target: function): luassert.Spy
local spy_factory = {}

--#region Spy Methods

---An instance of a spy.
---@class luassert.Spy
local spy = {}

---Revert the spied on function to its state before being spied on.
---
---Effectively removes spy from spied-on function.
function spy:revert() end

---Clear the call history for this spy.
function spy:clear() end

---Check how many times this spy has been called.
---@param times integer The expected number of calls
---@param compare? fun(callCount, expected): any A compare function, whose result will be returned as the first return value
---@return any result By default, `true` if the spy was called `times` times. Will be the result of `compare` if given
---@return integer calls Number of times called
function spy:called(times, compare) end

---Check that the spy was called with the provided arguments.
---@param args any[] -- an array of arguments that are expected to have been passed to this spy
---@return boolean was -- if this spy was called with the provided arguments
---@return any[] arguments --- if `was == false`, this will be an array of the arguments *last* given to this spy. If `was == true`, this will be an array of the arguments given to the matching call of this spy.
function spy:called_with(args) end

---Check that the spy returned the provided values
---@param ... any -- an array of values that are expected to have been returned by this spy
---@return boolean did -- if this spy did return the provided values.
---@return any[] returns -- if `did == false`, this will be an array of the values *last* returned by this spy. If `did == true`, this will be an array of the values returned by the matching call of this spy.
function spy:returned_with(...) end

--#endregion

--#region Spy Assertions

---The result of asserting a spy.
---
---Includes functions for performing assertions on a spy.
---@class luassert.spy.assert
local spy_assert = {}

---Assert that the function being spied on was called.
---@param times integer Assert the number of times the function was called
function spy_assert.called(times) end

spy_assert.was_called = spy_assert.called
spy_assert.was_not_called = spy_assert.called

---Assert that the function being spied on was called with the provided
---parameters.
---@param ... any The parameters that the function is expected to have been called with
function spy_assert.called_with(...) end

spy_assert.was_called_with = spy_assert.called_with

---Assert that the function being spied on was **NOT** called with the provided
---parameters.
---@param ... any The parameters that the function is expected to **NOT** have been called with
function spy_assert.not_called_with(...) end

spy_assert.was_not_called_with = spy_assert.not_called_with

---Assert that the function being spied on was called at **least** a specified
---number of times.
---@param times integer The minimum number of times that the spied-on function should have been called
function spy_assert.called_at_least(times) end

spy_assert.was_called_at_least = spy_assert.called_at_least

---Assert that the function being spied on was called at **most** a specified
---number of times.
---@param times integer The maximum number of times that the spied-on function should have been called
function spy_assert.called_at_most(times) end

---Assert that the function being spied on was called **more** than the
---specified number of times.
---@param times integer The number of times that the spied-on function should have been called more than
function spy_assert.called_more_than(times) end

---Assert that the function being spied on was called **less** than the
---specified number of times.
---@param times integer The number of times that the spied-on function should have been called less than
function spy_assert.called_less_than(times) end

---Check that the spy returned the provided values
---@param ... any An array of values that are expected to have been returned by this spy
---@return boolean did If this spy did return the provided values.
---@return any[] returns If `did == false`, this will be an array of the values *last* returned by this spy. If `did == true`, this will be an array of the values returned by the matching call of this spy.
function spy_assert.returned_with(...) end

local called = {
	with = spy_assert.called_with,
	at_least = spy_assert.called_at_least,
	at_most = spy_assert.called_at_most,
	more_than = spy_assert.called_more_than,
	less_than = spy_assert.called_less_than,
	at = {
		least = spy_assert.called_at_least,
		most = spy_assert.called_at_most,
	},
	more = { than = spy_assert.called_more_than },
	less = { than = spy_assert.called_less_than },
}

spy_assert.was = {
	called = called,
	called_with = spy_assert.called_with,
	not_called_with = spy_assert.not_called_with,
	called_at_least = spy_assert.called_at_least,
	called_at_most = spy_assert.called_at_most,
	called_more_than = spy_assert.called_more_than,
	called_less_than = spy_assert.called_less_than,
	returned_with = spy_assert.returned_with,
}
spy_assert.called = called
spy_assert.was_called = spy_assert.called
spy_assert.was.called = spy_assert.called
spy_assert.was.not_called = spy_assert.called

--#endregion

--#region Spy Factory Functions

---Register a new function to spy on.
---@param target function -- the function to spy on
---@return luassert.Spy spy -- a spy object that can be used to perform assertions
---
---## Example
---```
---describe("New Spy", function()
---    it("Registers a new function to spy on", function()
---        local s = spy.new(function() end)
---
---        s(1, 2, 3)
---        s(4, 5, 6)
---
---        assert.spy(s).was.called()
---        assert.spy(s).was.called(2)
---        assert.spy(s).was.called_with(1, 2, 3)
---    end)
---end)
---```
function spy_factory.new(target) end

---Create a new spy that replaces a method in a table in place.
---@param table table The table that the method is a part of
---@param methodName string The method to spy on
---@return luassert.Spy spy A spy object that can be used to perform assertions
---
---## Example
---```
---describe("Spy On", function()
---    it("Replaces a method in a table", function()
---        local t = {
---            greet = function(msg) print(msg) end
---        }
---
---        local s = spy.on(t, "greet")
---
---        t.greet("Hey!") -- prints 'Hey!'
---        assert.spy(t.greet).was_called_with("Hey!")
---
---        t.greet:clear()   -- clears the call history
---        assert.spy(s).was_not_called_with("Hey!")
---
---        t.greet:revert()  -- reverts the stub
---        t.greet("Hello!") -- prints 'Hello!', will not pass through the spy
---        assert.spy(s).was_not_called_with("Hello!")
---    end)
---end)
---```
function spy_factory.on(table, methodName) end

---Check that the provided object is a spy.
---@param object any The object to confirm is a spy
---@return boolean isSpy If the object is a spy or not
function spy_factory.is_spy(object) end

--#endregion

return spy_factory
