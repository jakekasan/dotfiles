local Logger = require("container.log").Logger
local M = {}

local log = Logger:new("status")

---@return boolean
local file_exists = function(path)
    local contents = io.read(path)
    return contents ~= nil
end

M.file_exists = file_exists

---@class DevContainerConfig
---@field name string
---@field context string
---@field container_args string[]
---@field run_args string[]
local DevContainerConfig = {}
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
--
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
local DevContainer = {}
function DevContainer:foo()
    local data = { }
    self.__index = self
    return setmetatable(data, self)
end

M.DevContainer = DevContainer
M.DevContainerConfig = DevContainerConfig

local Workspace = {}
function Workspace:new(root)
    local data = {root = root}
    self.__index = self
    return setmetatable(data, self)
end

function Workspace.create()
    local folder = Workspace:find_devcontainer_folder()
    if folder == nil then
        error("No workspace folder found...")
    end
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

