local function map(func, collection)
  local results = {}

  for index, value in pairs(collection) do
    local newValue, newIndex = func(value, index)
    results[newIndex or index] = newValue
  end

  return results
end

local function optionalMap(func, collection)
  local results = {}

  for index, value in pairs(collection) do
    local newValue, newIndex = func(value, index)
    if newValue then
      results[newIndex or index] = newValue
    end
  end

  return results
end

local function reduce(func, accum, collection)
  for index, value in pairs(collection) do
    accum = func(value, index, accum)
  end

  return accum
end

local function filter(func, collection)
  local results = {}

  for index, value in pairs(collection) do
    if func(value, index) then
      results[index] = value
    end
  end

  return results
end

local function assignOne(targetCollection, sourceCollection)
  for index, value in pairs(sourceCollection) do
    targetCollection[index] = value
  end
  return targetCollection
end

local function assign(targetCollection, ...)
  local sourceCollections = {...}
  for _, sourceCollection in ipairs(sourceCollections) do
    targetCollection = assignOne(targetCollection, sourceCollection)
  end
  return targetCollection
end

local function first(collection)
  return collection[1]
end

local function last(collection)
  return collection[#collection]
end

local function rest(collection)
  if #collection < 2 then
    return nil
  end

  local results = {}

  for i = 2, #collection do
    results[i - 1] = collection[i]
  end

  return results
end

local function concat(...)
  local result = {}

  for _, tbl in ipairs{...} do
    for _, val in pairs(tbl) do
      result[#result + 1] = val
    end
  end

  return result
end

return {
  map = map,
  optionalMap = optionalMap,
  reduce = reduce,
  filter = filter,
  assign = assign,
  first = first,
  last = last,
  rest = rest,
  concat = concat
}