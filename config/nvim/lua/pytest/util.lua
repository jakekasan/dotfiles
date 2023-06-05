local M = {}

local query = [[
(function_definition
    name: (identifier) @func_name
    (#match? @func_name "test_.*"))
]]

local parsed_query = vim.treesitter.query.parse("python", query)

---@param node TSNode
---@param bufnr integer
local get_node_name = function(node, bufnr)
    for child in node:iter_children() do
        if child:type() == "identifier" then
            return vim.treesitter.get_node_text(child, bufnr)
        end
    end
end

---@param node TSNode
---@param bufnr integer
---@return string
M.get_full_name = function(node, bufnr)
    local parts = { vim.treesitter.get_node_text(node, bufnr)}
    local this = node
    while this and this:type() ~= "module" do
        if this:type() == "class_definition" then
            local local_name = get_node_name(this, bufnr)
            if local_name ~= nil then
                table.insert(parts, 1, local_name)
            end
        end

        vim.notify(string.format("Current type: %s", this:type()))
        this = this:parent()
    end
    local last_type, err = pcall(function() this:type() end)
    if err == nil then
        vim.notify(string.format("Last type: %s", last_type))
    end
    return table.concat(parts, ".")
end

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
            vim.notify(string.format("Capture text: '%s'", text))
            local full_name = M.get_full_name(node, bufnr)
            vim.notify(string.format("Full name '%s'", full_name))
        end
    end
end

OUTBUF = 32

local log = function(data)
    vim.api.nvim_buf_set_lines(OUTBUF, -1, -1, false, {data})
end

local function get_indent(line)
    log("Calculating indent")
    local result = string.match(line, "(%s+)<")
    log(string.format("Indent match: '%s'", result))
    return string.len(result or "")
end

local function get_module_name(line)
    return string.match(line, "Module%s(.%S+)>")
end

local function get_func_name(line)
    return string.match(line, "Function%s(.%S+)>")
end

local function get_class_name(line)
    return string.match(line, "Class%s(.%S+)>")
end

local function handle_data(_, data)
    if not data then
        return
    end
    log("Here starts logging")

    local tests = {}

    local last_indent = 0
    local parts = {}
    for _, line in ipairs(data) do
        log(string.format("Line: '%s'", line))
        local module_match = get_module_name(line)
        local func_match = get_func_name(line)
        local class_match = get_class_name(line)

        log("Getting indent")
        local this_indent = get_indent(line)
        if this_indent < last_indent then
            log("Indent decreased, popping last item..")
            table.remove(parts)
        end
        log("Got indent")
        last_indent = this_indent

        log("Checking matches...")
        if module_match ~= nil then
            log(string.format("Module match: '%s'", module_match))
            parts = {module_match}
        elseif class_match ~= nil then
            log(string.format("Class match: '%s'", class_match))
            table.insert(parts, class_match)
        elseif func_match ~= nil then
            log(string.format("Func match: '%s'", func_match))
            table.insert(tests, vim.tbl_flatten({ parts, { func_match } }))
        else
            log("Nothing matched.")
        end

    end
    log(vim.inspect(tests))
    log("Logging Ends")
end

local function handle_error(_, data)
    if not data then
        return
    end
    for _, line in ipairs(data) do
        if line ~= "" then
            log(line)
        end
    end
end

M.discover_pytests = function (bufnr)
    print(string.format("Disovering for buffer %d", bufnr))
    vim.fn.jobstart("source .venv/bin/activate && pytest --collect-only", {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = handle_data,
        on_stderr = handle_error
    })
end

-- M.discover_tests(BUFNR)
M.discover_pytests(0)

-- vim.notify(vim.inspect(string.match("    <Module this_module>", "Module%s(%S+)>")))

