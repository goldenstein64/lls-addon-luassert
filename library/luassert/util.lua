---@meta

---utility methods used by luassert
---@class luassert.util
local util = {}

---equivalent to `table.pack`
---@generic T
---@param ... T
---@return T[]
---@overload fun<T1>(arg1: T1): [T1]
---@overload fun<T1, T2>(arg1: T1, arg2: T2): [T1, T2]
---@overload fun<T1, T2, T3>(arg1: T1, arg2: T2, arg3: T3): [T1, T2, T3]
---@overload fun<T1, T2, T3, T4>(arg1: T1, arg2: T2, arg3: T3, arg4: T4): [T1, T2, T3, T4]
---@overload fun<T1, T2, T3, T4, T5>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5): [T1, T2, T3, T4, T5]
---@overload fun<T1, T2, T3, T4, T5, T6>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6): [T1, T2, T3, T4, T5, T6]
---@overload fun<T1, T2, T3, T4, T5, T6, T7>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6, arg7: T7): [T1, T2, T3, T4, T5, T6, T7]
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6, arg7: T7, arg8: T8): [T1, T2, T3, T4, T5, T6, T7, T8]
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8, T9>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6, arg7: T7, arg8: T8, arg9: T9): [T1, T2, T3, T4, T5, T6, T7, T8, T9]
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(arg1: T1, arg2: T2, arg3: T3, arg4: T4, arg5: T5, arg6: T6, arg7: T7, arg8: T8, arg9: T9, arg10: T10): [T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, ...]
function util.pack(...) end

---equivalent to `table.unpack`
---@generic T
---@param list T[]
---@param i integer
---@param j integer
---@return T ...
---@overload fun<T1>(list: [T1]): (T1)
---@overload fun<T1, T2>(list: [T1, T2]): (T1, T2)
---@overload fun<T1, T2, T3>(list: [T1, T2, T3]): (T1, T2, T3)
---@overload fun<T1, T2, T3, T4>(list: [T1, T2, T3, T4]): (T1, T2, T3, T4)
---@overload fun<T1, T2, T3, T4, T5>(list: [T1, T2, T3, T4, T5]): (T1, T2, T3, T4, T5)
---@overload fun<T1, T2, T3, T4, T5, T6>(list: [T1, T2, T3, T4, T5, T6]): (T1, T2, T3, T4, T5, T6)
---@overload fun<T1, T2, T3, T4, T5, T6, T7>(list: [T1, T2, T3, T4, T5, T6, T7]): (T1, T2, T3, T4, T5, T6, T7)
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8>(list: [T1, T2, T3, T4, T5, T6, T7, T8]): (T1, T2, T3, T4, T5, T6, T7, T8)
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8, T9>(list: [T1, T2, T3, T4, T5, T6, T7, T8, T9]): (T1, T2, T3, T4, T5, T6, T7, T8, T9)
---@overload fun<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(list: [T1, T2, T3, T4, T5, T6, T7, T8, T9, T10]): (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
function util.unpack(list, i, j) end

---Determine whether `t1` and `t2` are the same table.
---@param t1 unknown
---@param t2 unknown
---@param ignore_mt? boolean -- Should it use `__eq` metamethod? Defaults to `false`.
---@param cycles? [{ [unknown]: integer }, { [unknown]: integer }] -- contains the number of times a table has been visited while visiting said table. Defaults to `{{}, {}}`
---@param thresh1? integer -- determines the maximum number of times a table in `t1` can be visited while visiting said table. Defaults to 1.
---@param thresh2? integer -- determines the maximum number of times a table in `t2` can be visited while visiting said table. Defaults to 1.
---@return boolean same -- whether `t1` and `t2` are the same
---@return unknown[] crumbs -- where the comparison fails as an array of keys, `nil` if comparison succeeds
function util.deepcompare(t1, t2, ignore_mt, cycles, thresh1, thresh2) end

---If `t` is a table, copy `t`'s key-value pairs to a new table, and set its
---metatable to the same one as `t`'s. Otherwise, return `t`.
---@generic T
---@param t T -- the value to create a copy of
---@return T copy -- the new value
function util.shallowcopy(t) end

---If `t` is a table, copy `t`'s key-values pairs to a new table, and copy the
---values before moving them.
---Otherwise, return `t`.
---
---If `deepmt` is truthy, copy metatables to the new table.
---@generic T
---@param t T -- the value to create a copy of
---@param deepmt? boolean -- deep copy metatables. Defaults to `false`.
---@param cache? { [unknown]: unknown } -- tracks copies of `t` and its descendant values
---@return T copy -- the new value
function util.deepcopy(t, deepmt, cache) end

---Copies arguments as a list of arguments
---@generic T
---@param args T -- the arguments of which to copy
---@return { vals: T, refs: T } -- a deep copy stored in `vals` and a shallow copy stored in `refs`
function util.copyargs(args) end

---clear an arguments or return values list from a table
---@param arglist luassert.util.ArgList -- the table to clear of arguments or return values and their count
function util.cleararglist(arglist) end

---@class luassert.util.ArgList
---@field [integer] any
---@field n integer

---Find matching arguments/return values in a saved list of arguments/returned
---values.
---@param invocations_list luassert.util.ArgList -- list of arguments/returned values to search (list of lists)
---@param specs (unknown | fun(value: unknown): boolean)[] -- arguments/return values to match against argslist
---@return any? -- the first matching arguments/returned values if a match is found, otherwise nil
function util.matchargs(invocations_list, specs) end

---@param oncalls { vals: (unknown | fun(value: unknown): boolean)[] }[]
---@param args any[]
function util.matchoncalls(oncalls, args) end

---`table.insert()` replacement that respects `nil`. The function will use table
---field `n` as indicator of the table length. If not set, it will be added.
---@param t table -- table into which to insert
---@param pos integer? -- position in table where to insert. NOTE: must be explicitly set to `nil` if you want to insert a `nil` value!
---@param val unknown -- value to insert
---@overload fun(t: table, val: unknown)
function util.tinsert(t, pos, val) end

---`table.remove()` replacement that respects `nil`. The function will use table
---field `n` as indicator of the table length. If not set, it will be added.
---@param t table -- table from which to remove
---@param pos? integer -- position in table to remove
---@return any val
function util.tremove(t, pos) end

---Checks an element to be callable.
---The type must either be a function or have a metatable
---containing an '__call' function.
---@param object unknown -- element to inspect on being callable or not
---@return boolean -- `true` if the object is callable
function util.callable(object) end

---Checks an element has tostring.
---The type must either be a string or have a metatable
---containing an '__tostring' function.
---@param object unknown -- element to inspect on having tostring or not
---@return boolean -- `true` if the object has tostring
function util.hastostring(object) end

---Find the first level, not defined in the same file as the caller's code file
---to properly report an error.
---@param level? integer -- the level to use as the caller's source file. Defaults to 1.
---@return integer -- the level of which to report an error
function util.errorlevel(level) end

---Extract modifier and namespace keys from list of tokens.
---@param nspace string -- the namespace from which to match tokens
---@param tokens string[] -- list of tokens to search for keys
---@return string[] -- list of keys that were extracted
function util.extract_keys(nspace, tokens) end

---store argument list for return values of a function in a table. The table
---will get a metatable to identify it as an arglist
---@param ... any
---@return luassert.util.ArgList
function util.make_arglist(...) end

---check a table to be an arglist type.
---@param object unknown
---@return boolean
function util.is_arglist(object) end

return util
