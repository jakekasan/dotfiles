local get_full_name = require("pytest.util").get_full_name

local M = {}

M.tests = {}

local query = [[
(function_definition
    name: (identifier) @func_name
    (#match? @func_name "test_.*"))
]]

local parsed_query = vim.treesitter.query.parse("python", query)

M.discover_tests = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype ~= "python" then
        vim.notify("Only for python")
        return
    end
    local parser = vim.treesitter.get_parser(bufnr, "python", {})
    local root = parser:parse()[1]:root()
    for id, node in parsed_query:iter_captures(root, bufnr, 0, -1) do
        local name = parsed_query.captures[id]
        if name == "func_name" then
            local text = vim.treesitter.get_node_text(node, bufnr)
            vim.notify(string.format("Capture text: %s", text))
            local full_name = get_full_name(node)
            vim.notify(full_name)
        end
    end
end

return M


