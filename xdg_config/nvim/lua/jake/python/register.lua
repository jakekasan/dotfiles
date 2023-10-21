Test = {}

function Test:new()
    local obj = {}
    self.__index = self
    return setmetatable(obj, self)
end

File = {}

function File:new(file)
    local obj = {
        file = file
    }
    self.__index = self
    return setmetatable(obj, self)
end

function File:discover_tests()
    local thing = vim.treesitter.query()
end

Register = {}

function Register:new()
    local obj = {
        files = {}
    }
    self.__index = self
    return setmetatable(obj, self)
end

function Register:add_file(file)
    self.files[file] = File:new(file)
end

return {
    Register = Register,
    File = File
}

