---@meta

---@deprecated -- use luassert.util
---@see luassert.util
---@class luassert.compatibility
local compatibility = {}

---@generic T1, T2, T3, T4, T5, T6, T7, T8, T9
---@param list [T1, T2, T3, T4, T5, T6, T7, T8, T9]
---@return T1, T2, T3, T4, T5, T6, T7, T8, T9
function compatibility.unpack(list) end

---a wrapper around `unpack`
---@version 5.1
---@generic T1, T2, T3, T4, T5, T6, T7, T8, T9, T10
---@param list [T1?, T2?, T3?, T4?, T5?, T6?, T7?, T8?, T9?, T10?]
---@param i? integer
---@param j? integer
---@return T1, T2, T3, T4, T5, T6, T7, T8, T9, T10
function compatibility.unpack(list, i, j) end

return compatibility
