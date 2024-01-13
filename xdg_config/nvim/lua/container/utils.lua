
local M = {}

---Throws an error if value is not of type `string` otherwise returns it.
---@param value any
---@return string
M.ensure_is_string = function(value)
    if type(value) ~= "string" then
        error("Value '" .. value .. "' was not a string")
    end
    return value
end

---Throws an error if value is not a table or if any of the values given by ipairs is not a `string`.
---@param value any
---@return string[]
M.ensure_is_array_of_strings = function(value)
    if type(value) ~= "table" then
        error("Expected a 'table', not '" .. type(value) .. "'")
    end

    ---@type string[]
    local results = {}
    for i, item in ipairs(value) do
        if type(item) ~= "string" then
            error("Value at index " .. i .. " is not string but '" .. type(item) .. "'")
        else
            table.insert(results, item)
        end
    end

    return results
end

---Reads a file, parses it as JSON into a table and then returns this.
---@param path string
M.read_as_json = function(path)
    local content = io.read(path)
    if type(content) ~= "string" then
        error("File at path '" .. path .. "' could not be loaded")
    end

    if content == nil or type(content) ~= "string" then
        error("Unable to read content from " .. path)
    end

    local data = vim.json.decode(content)

    if data == nil or type(data) ~= "table" then
        error("Expected to load a table, instead got '" .. type(data) .. "'")
    end

    return data
end

return M

