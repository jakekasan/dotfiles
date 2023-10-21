
local M = {}

local tests_by_test_file = {}

M.file_registered = function(file_name)
    for key, _ in pairs(tests_by_test_file) do
        if key == file_name then
            return true
        end
    end
    return false
end

M.register_file = function(file_name)
    if not M.file_registered(file_name) then
        tests_by_test_file[file_name] = {}
    end
end

M.registerd_files = function()
    return vim.tbl_keys(tests_by_test_file)
end

return M

