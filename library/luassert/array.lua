---@meta

---@class luassert.array.assert
local array = {}

---Assert that an array has holes in it
---@param length? integer The expected length of the array
---@return integer|nil holeIndex The index of the first found hole or `nil` if there was no hole.
function array.holes(length) end

array.has_holes = array.holes
array.has_no_holes = array.holes

array.has = array
array.no = array
array.has_no = array

return array
