---@meta

---maintains snapshots of internal luassert state used to revert mocks, spies,
---argument formatters and parameters
---@class luassert.state
local state = {}

---@alias luassert.state.Formatter fun(val: unknown, fmtargs: unknown): unknown?

---@class luassert.state.Snapshot
---@field spies { [luassert.Spy]: true? }
---@field formatters luassert.state.Formatter[]
---@field parameters { [any]: any }
---@field previous? luassert.state.Snapshot
---@field next? luassert.state.Snapshot
---@overload fun()
local snapshot = {}

---Revert to the snapshot before this one.
function snapshot() end

---Revert to the snapshot before this one.
function snapshot:revert() end

---Revert to the snapshot before `self`. If `self` is not provided, it will revert
---to the last snapshot.
---@param self? luassert.state.Snapshot -- what to revert from
function state.revert(self) end

---Create a new snapshot.
---@see luassert.snapshot
---@return luassert.state.Snapshot -- snapshot table
function state.snapshot() end

---Add a format function `callback` that takes a value and format arguments.
---@see luassert.add_formatter
---@param callback luassert.state.Formatter
function state.add_formatter(callback) end

---Remove `callback` from the formatter registry.
---@see luassert.remove_formatter
---@param callback luassert.state.Formatter
---@param snapshot? luassert.state.Snapshot
function state.remove_formatter(callback, snapshot) end

---Run each registered formatter until one returns a value.
---@see luassert.format
---@param val unknown
---@param snapshot? luassert.state.Snapshot
---@param fmtargs unknown
---@return string?
function state.format_argument(val, snapshot, fmtargs) end

---Set a parameter. It can be accessed via `state.get_parameter` or
---`assert:get_parameter`
---@param name string
---@param value unknown
function state.set_parameter(name, value) end

---Get a parameter. It can be modified via `state.set_parameter` or
---`assert:set_parameter`
---@param name string
---@param snapshot? luassert.state.Snapshot
---@return unknown value
function state.get_parameter(name, snapshot) end

---Add a spy to the current snapshot.
---@param spy luassert.Spy
function state.add_spy(spy) end

return state
