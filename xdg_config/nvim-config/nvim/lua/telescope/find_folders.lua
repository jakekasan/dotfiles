local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

M.find_folders = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local one_shot_finder = finders.new_oneshot_job(
    { "find", ".", "-type", "d", "-mindepth", "1" },
    { cwd = opts.cwd, entry_maker = make_entry.gen_from_string(opts) }
  )

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Find Folders",
      finder = one_shot_finder,
      previewer = conf.grep_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

M.setup = function() end

return M
