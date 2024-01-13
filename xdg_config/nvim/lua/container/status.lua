local Logger = require("container.log").Logger
local M = {}

local log = Logger:new("status")

---@return boolean
local file_exists = function(path)
    local contents = io.read(path)
    return contents ~= nil
end

---@class DevContainerConfig
---@field user string
---@field context string
---@field container_args string[]
---@field run_args string[]

local DevContainerConfig = {}
---@param name string
---@param context string
---@param container_args string[]
---@param run_args string[]
function DevContainerConfig:new(name, context, container_args, run_args)
    local data = {
        name = name,
        context = context,
        container_args = container_args,
        run_args = run_args
    }
    self.__index = self
    return setmetatable(data, self)
end

---@param value any
---@return string
local function ensure_is_string(value)
    if type(value) ~= "string" then
        error("Value '" .. value .. "' was not a string")
    end
    return value
end

---@param value any
---@return string[]
local function ensure_is_array_of_strings(value)
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

---@param path string
local function read_as_json(path)
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

---@param path string
---@return DevContainerConfig
function DevContainerConfig:from_json_file(path)
    local data = read_as_json(path)
    return self:from_json(data)
end

---@param data table
---@return DevContainerConfig
function DevContainerConfig:from_json(data)
    local name = ensure_is_string(data.name)
    local context = ensure_is_string(data.context)
    local container_args = ensure_is_array_of_strings(data.container_args)
    local run_args = ensure_is_array_of_strings(data.run_args)
    return self:new(name, context, container_args, run_args)
end

---@class DevContainer
---@field private dockerfile string
---@field private config DevContainerConfig
local DevContainer = {}
function DevContainer:new()
    local data = { }
    self.__index = self
    return setmetatable(data, self)
end

M.DevContainer = DevContainer
M.DevContainerConfig = DevContainerConfig

---@class Workspace
---@field private root string
local Workspace = {}
function Workspace:new(root)
    local data = {root = root}
    self.__index = self
    return setmetatable(data, self)
end

function Workspace:create()
    local folder = Workspace:find_devcontainer_folder()
end

---@return string?
function Workspace:find_devcontainer_folder()
    local stop = vim.loop.cwd()
    local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    log:debug("Searching for devcontainer folder (stop='" .. stop .. "', path='" .. path .. "'")
    local result = vim.fs.find(
        ".devcontainer",
        {
            upward = true,
            stop = stop,
            path = path
        }
    )
    if result == nil then
        log:error("Devcontainer folder not found")
        return
    end
    log:debug("Found devcontainer folder " .. vim.inspect(result))
    return result[1]
end

---@return boolean
function Workspace:has_devcontainer()
    local result = vim.fs.find("devcontainer.json", { upward = false, path = self.root })
    print("has_dev_container_json=" .. vim.inspect(result))
    return result ~= nil
end

M.Workspace = Workspace

--- checks is the docker daemon is running
---@param name string?
---@return boolean
M.is_docker_running = function (name)
    local process_name = name or "docker"
    local job_id = vim.fn.jobstart({"pgrep", process_name}, {})
    local docker_exists = vim.fn.jobwait(job_id, -1) == 0
    print("Finished with result=" .. docker_exists)
    return docker_exists
end

---comment
---@param parent string
---@return boolean
M.has_dev_container_json = function (parent)
    local result = vim.fs.find("devcontainer.json", { upward = false, path = parent })
    print("has_dev_container_json=" .. vim.inspect(result))
    return result ~= nil
end

---comment
---@param parent string
---@return boolean
M.has_dev_container_docker = function (parent)
    local result = vim.fs.find("Dockerfile", { upward = false, path = parent })
    print("has_dev_container_docker=" .. vim.inspect(result))
    return result ~= nil
end

---comment
---@param cwd string | nil
---@return boolean
M.is_dev_container = function (cwd)
    local workspace_dir = cwd or vim.fn.getcwd()
    if not M.has_dev_container_json(workspace_dir) then
        return false
    end
    if not M.has_dev_container_docker(workspace_dir) then
        return false
    end
    return true
end

return M

