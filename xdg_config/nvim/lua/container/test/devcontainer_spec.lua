local assert = require("luassert.assert")
local DevContainerConfig = require("container.status").DevContainerConfig

local function foo()
    return "foo"
end

describe("DevContainerConfig", function()
    describe("from_json()", function()
        it("missing name errors", function ()
            local input = {}
            assert.is.error(function() DevContainerConfig:from_json(input) end)
        end)

        it("missing context errors", function ()
            local input = { name = "some name" }
            assert.is.error(function() DevContainerConfig:from_json(input) end)
        end)

        it("missing run args errors", function ()
            local input = { name = "some name", context = ".." }
            assert.is.error(function() DevContainerConfig:from_json(input) end)
        end)

        it("missing container args errors", function ()
            local input = { name = "some name", context = "..", run_args = {} }
            assert.is.error(function() DevContainerConfig:from_json(input) end)
        end)
        
        it("all good", function ()
            local input = { name = "some name", context = "..", run_args = {}, container_args = {} }
            assert.is_not.error(function() DevContainerConfig:from_json(input) end)
        end)
    end)
end)

