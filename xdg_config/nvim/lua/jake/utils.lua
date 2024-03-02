local DEFAULT_OPTS = {}
local curr_opts = {}

local function reset_opts()
    curr_opts = vim.tbl_extend("force", {}, DEFAULT_OPTS)
end

local function add_opts(new_opts)
    curr_opts = vim.tbl_extend("force", curr_opts, new_opts)
end

local function make_map(mode, opts)
    return function(mapping, func, desc)
        vim.keymap.set(mode, mapping, func, vim.tbl_extend("force", opts, {desc = desc}))
    end
end


return {
    make_map = make_map,
    nmap = make_map("n"),
    imap = make_map("i"),
    vmap = make_map("v"),
    add_opts = add_opts,
    reset_opts = reset_opts
}
