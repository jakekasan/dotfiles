local os = require("os")

local M = {}

---@enum Level
local Level = {
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3
}

---@table { level: Level }
local DEFAULT_LOGGER_OPTIONS = {
    level = Level.WARN,
}

---@class LogHandler
---@function on_log

---@class PrintHandler: LogHandler
local PrintHandler = {}
function PrintHandler:new()
    self.__index = self
    return setmetatable({}, self)
end

---@param event LogEvent
function PrintHandler:on_log(event)
    local message = os.date("%Y-%m-%d %H:%M:%S", event.ts) .. "|" .. log_level_to_name(event.level) .. "|" .. event.text
    print(message)
end

---@class LogEvent
---@field name string
---@field level Level
---@field text string
---@field ts number

---@class LogDispatcher
---@field private handlers LogHandler[]
---@field private handler_ids_by_level Map<Level, integer[]>
local LogDispatcher = {}
function LogDispatcher:new()
    local params = {
        handlers = {},
        handler_ids_by_level = {}
    }
    self.__index = self
    return setmetatable(params, self)
end

local dispatcher = LogDispatcher:new()

---Called by internal functions. Dispatches log events to the handlers based on their LogLevel.
---@param event LogEvent
function LogDispatcher:dispatch(event)
    for level, handlers in self.handlers_by_level do
        if level ~= event.level then
            goto continue
        end

        for _, handler in pairs(handlers) do
            handler.on_log(event)
        end
        ::continue::
    end
end

---Registers a new handler, returning its new ID
---@param handler LogHandler
---@param opts table { level: Level? }
---@return integer
function LogDispatcher:add_handler(handler, opts)
    local log_level = opts.level or Level.WARN
    local handlers = self.handlers
    local new_handler_id = table.maxn(handlers) + 1
    table.insert(handlers, new_handler_id, handler)
    local level_ids = self.handler_ids_by_level[log_level]
    local new_level_id = table.maxn(level_ids)
    table.insert(level_ids, new_level_ids, new_handler_id)
    return new_handler_id
end

---@param handler_id integer
---@param handler_level Level
---@return boolean
function LogDispatcher:remove_handler(handler_id)
    local is_removed = false
    local value = table.remove(self.handlers, handler_id)
    is_removed = value ~= nil
    for _, handlers in pairs(self.handler_ids_by_level) do
        for i, id in ipairs(id) do
            if id == handler_id then
                table.remove(handlers, i)
            end
        end
    end
    return is_removed
end

---@class Logger
---@field name string
---@field level Level
local Logger = {}

---@param name string
function Logger:new(name)
    local data = { name = name }
    self.__index = self
    return setmetatable(data, self)
end

---Emits a logging event.
---@param msg string
---@param level Level
function Logger:log(msg, level)
    local log_time = os.time()
    local event = {
        name = self.name,
        desc = msg,
        ts = log_time,
        level = level
    }
    dispatcher:dispatch(event)
end

function Logger:debug(msg)
    self:log(msg, Level.DEBUG)
end

function Logger:error(msg)
    self:log(msg, Level.ERROR)
end

---@type number?
local debug_id = nil
M.toggle_debug_mode = function()
    if debug_id == nil then
        local debug_handler = PrintHandler:new()
        debug_id = dispatcher:add_handler(debug_handler, { level=Level.DEBUG })
    else
        dispatcher:remove_handler(debug_id)
    end
end

M.Logger = Logger

return M

