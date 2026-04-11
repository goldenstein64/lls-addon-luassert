---@meta

---@class luassert.Matcher
---@field name string
---@field callback fun(state: any, arguments: { [integer]: any, n: integer }, errorlevel)
---@overload fun(value: any): boolean

---Matchers are used to provide flexible argument matching for `called_with` and
---`returned_with` asserts for spies. Just like with asserts, you can chain a
---modifier value using `is` or `is_not`, followed by the matcher you wish to use.
---@class luassert.match
local match = {}

---Check whether a value is a matcher.
---@param matcher unknown
---@return boolean
function match.is_matcher(matcher) end

---Check whether a value is a ref matcher.
---@param matcher unknown
---@return boolean
function match.is_ref_matcher(matcher) end

---Match a value from a spy.
match.is = match
match.a = match
match.an = match
match.the = match
match.are = match
match.was = match
match.has = match
match.does = match

---Match inverse values from a spy.
match.is_not = match
match.Not = match.is_not
match.No = match.is_not
match.no = match.is_not

---wildcard match, matches anything
---@type luassert.Matcher
---
---## Example
---
---```
---it("tests wildcard matcher", function()
---    local s = spy.new(function() end)
---    local _ = match._
---
---    s("foo")
---
---    assert.spy(s).was_called_with(_)        -- matches any argument
---    assert.spy(s).was_not_called_with(_, _) -- does not match two arguments
---end)
---```
match._ = nil

--#region Modifiers

---If you're creating a spy for functions that mutate any properties on a table
---(like `self`) and you want to use `was_called_with`, you should use
---`match.is_ref(obj)`.
---@param obj any
---@return luassert.Matcher
---
---## Example
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests ref matchers for passed in table", function()
---        local t = { count = 0, }
---        function t.incrby(t, i) t.count = t.count + i end
---
---        local s = spy.on(t, "incrby")
---
---        s(t, 2)
---
---        assert.spy(s).was_called_with(match.is_ref(t), 2)
---    end)
---
---    it("tests ref matchers for self", function()
---        local t = { count = 0, }
---        function t:incrby(i) self.count = self.count + i end
---
---        local s = spy.on(t, "incrby")
---
---        t:incrby(2)
---
---        assert.spy(s).was_called_with(match.is_ref(t), 2)
---    end)
---end)
---```
function match.is_ref(obj) end
match.ref = match.is_ref
match.Ref = match.is_ref
match.is_not_ref = match.is_ref

---Combine matchers, matching all provided matchers.
---@param ... table|function
---@return luassert.Matcher
---
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_all_of(
---            match.is_not_nil(),
---            match.is_not_number()
---        ))
---    end)
---end)
---```
function match.all_of(...) end
match.is_all_of = match.all_of
match.all = { of = match.all_of }

---Combine matchers, matching at least one provided matcher.
---@param ... table|function
---@return luassert.Matcher
---
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_any_of(
---            match.is_number(),
---            match.is_string(),
---            match.is_boolean()
---        ))
---    end)
---end)
---```
function match.any_of(...) end
match.is_any_of = match.any_of
match.any = { of = match.any_of }

---Combine matchers, matching none of the provided matchers.
---@param ... table|function
---```lua
---describe("combine matchers", function()
---    local match = require("luassert.match")
---
---    it("tests composite matchers", function()
---        local s = spy.new(function() end)
---
---        s("foo")
---
---        assert.spy(s).was_called_with(match.is_none_of(
---            match.is_number(),
---            match.is_table(),
---            match.is_boolean()
---        ))
---    end)
---end)
---```
function match.none_of(...) end
match.is_none_of = match.none_of

--#endregion

--#region Matchers

---Check that the value is `true`.
---@return luassert.Matcher
function match.is_true() end
match.True = match.is_true

---Check that the value is `false`.
---@return luassert.Matcher
function match.is_false() end
match.False = match.is_false

---Check that the value is `nil`.
---@return luassert.Matcher
function match.is_nil() end
match.Nil = match.is_nil

---Check that the value is of type `boolean`.
---@return luassert.Matcher
function match.is_boolean() end
match.boolean = match.is_boolean
match.Boolean = match.is_boolean

---Check that the value is of type `number`.
---@return luassert.Matcher
function match.is_number() end
match.Number = match.is_number
match.number = match.is_number

---Check that the value is of type `string`.
---@return luassert.Matcher
function match.is_string() end
match.string = match.is_string
match.String = match.is_string

---Check that the value is of type `table`.
---@return boolean isTable
function match.is_table() end
match.table = match.is_table
match.Table = match.is_table

---Check that the value is of type `function`.
---@return boolean isFunction
function match.is_function() end
match.Function = match.is_function

---Check that the value is of type `userdata`.
---@return boolean isUserdata
function match.is_userdata() end
match.Userdata = match.is_userdata
match.userdata = match.is_userdata

---Check that the value is of type `thread`.
---@return boolean isThread
function match.is_thread() end
match.thread = match.is_thread
match.Thread = match.is_thread

---Check that the value is truthy.
---@return boolean isTruthy
function match.is_truthy() end
match.truthy = match.is_truthy
match.Truthy = match.is_truthy

---Check that the value is falsy.
---@return boolean isFalsy
function match.is_falsy() end
match.Falsy = match.is_falsy
match.falsy = match.is_falsy

---Check that the two values are equal.
---
---When comparing tables, a reference check will be used.
---@param value any The target value
---@return boolean isEqual
function match.are_equal(value) end
match.equal = match.are_equal
match.equals = match.are_equal
match.Equal = match.are_equal
match.Equals = match.are_equal
match.is_equal = match.are_equal

---Check that the two values are considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param value any The target value
---@return boolean isSame
function match.are_same(value) end
match.same = match.are_same
match.Same = match.are_same
match.is_same = match.are_same

---Match a table with unique values. Will pass if no values are duplicates.
---@param deep boolean If a deep check should be performed or just the first level
---@return boolean isUnique
function match.is_unique(deep) end
match.unique = match.is_unique
match.Unique = match.is_unique
match.is_unique = match.is_unique

---Match a certain numerical value with a specified +/- tolerance.
---@param value number The target value
---@param tolerance number The amount that the true value can be off by (inclusive)
---@return boolean isNear
function match.is_near(value, tolerance) end
match.near = match.is_near
match.Near = match.is_near

---Perform a `string.find()` match.
---@param pattern string String match pattern
---@param init integer Index of character to start searching for a match at
---@param plain boolean If the `pattern` should be treated as plain text instead of a pattern
---@return boolean matches
function match.matches(pattern, init, plain) end
match.Matches = match.matches
match.does_match = match.matches
match.has_match = match.matches
match.match = match.matches
match.Match = match.matches
match.is_match = match.matches

--#endregion

--#region Inverse Matchers

---Check that the value is **NOT** `true`.
---@return boolean isTrue
function match.is_not.True() end
match.is_not_true = match.is_not.True

---Check that the value is **NOT** `false`.
---@return boolean isFalse
function match.is_not.False() end
match.is_not_false = match.is_not.False

---Check that the value is **NOT** `nil`.
---@return boolean isNil
function match.is_not.Nil() end
match.is_not_nil = match.is_not.Nil

---Check that the value is **NOT** of type `boolean`.
---@return boolean isBoolean
function match.is_not.Boolean() end
match.is_not.boolean = match.is_not.Boolean
match.is_not_boolean = match.is_not.Boolean

---Check that the value is **NOT** of type `number`.
---@return boolean isNumber
function match.is_not.Number() end
match.is_not.number = match.is_not.Number
match.is_not_number = match.is_not.Number

---Check that the value is **NOT** of type `string`.
---@return boolean isString
function match.is_not.String() end
match.is_not.string = match.is_not.String
match.is_not_string = match.is_not.String

---Check that the value is **NOT** of type `table`.
---@return boolean isTable
function match.is_not.Table() end
match.is_not.table = match.is_not.Table
match.is_not_table = match.is_not.Table

---Check that the value is **NOT** of type `function`.
---@return boolean isFunction
function match.is_not.Function() end
match.is_not_function = match.is_not.Function

---Check that the value is **NOT** of type `userdata`.
---@return boolean isUserdata
function match.is_not.Userdata() end
match.is_not.userdata = match.is_not.Userdata
match.is_not_userdata = match.is_not.Userdata

---Check that the value is **NOT** of type `thread`.
---@return boolean isThread
function match.is_not.Thread() end
match.is_not.Thread = match.is_not.Thread
match.is_not_thread = match.is_not.Thread

---Check that the value is **NOT** truthy.
---@return boolean isTruthy
function match.is_not.truthy() end
match.is_not.Truthy = match.is_not.truthy
match.is_not_truthy = match.is_not.truthy

---Check that the value is **NOT** falsy.
---@return boolean isFalsy
function match.is_not.falsy() end
match.is_not.Falsy = match.is_not.falsy
match.is_not_falsy = match.is_not.falsy

---Check that the two values are **NOT** equal.
---
---When comparing tables, a reference check will be used.
---@param value any The target value
---@return boolean isEqual
function match.is_not.Equals(value) end
match.is_not.equals = match.is_not.Equals
match.is_not_equals = match.is_not.Equals

---Check that the two values are **NOT** considered the "same".
---
---When comparing tables, a deep compare will be performed.
---@param value any The target value
---@return boolean isSame
function match.is_not.Same(value) end
match.is_not.same = match.is_not.Same
match.is_not_same = match.is_not.Same

---Match a table with **NOT** unique values. Will pass if at least one duplicate is found.
---@param deep boolean If a deep check should be performed or just the first level
---@return boolean isUnique
function match.is_not.Unique(deep) end
match.is_not.unique = match.is_not.Unique
match.is_not_unique = match.is_not.Unique

---Match a certain numerical value outside a specified +/- tolerance.
---@param value number The target value
---@param tolerance number The amount that the true value must be off by (inclusive)
---@return boolean isNear
function match.is_not.Near(value, tolerance) end
match.is_not.near = match.is_not.Near
match.is_not_near = match.is_not.Near

---Perform a `string.find()` match to find a value that does **NOT** match.
---@param pattern string String match pattern
---@param init integer Index of character to start searching for a match at
---@param plain boolean If the `pattern` should be treated as plain text instead of a pattern
---@return boolean matches
function match.is_not.Matches(pattern, init, plain) end
match.is_not.matches = match.is_not.Matches
match.is_not_matches = match.is_not.Matches
match.is_not.match = match.is_not.Matches
match.is_not_match = match.is_not.Matches

--#endregion

return match
