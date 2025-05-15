local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}

M.find_folders = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local one_shot_finder = finders.new_oneshot_job(
    { "find", ".", "-type", "d", "-mindepth", "1"},
    { cwd = opts.cwd, entry_maker = make_entry.gen_from_string(opts) }
  )

  -- local finder = finders.new_dynamic({
  --   fn = function(prompt)
  --     local job1 = vim.system({
  --       "find",
  --       ".",
  --       "-type",
  --       "d",
  --     }, { cwd=opts.cwd }):wait()
  --
  --     local job2 = vim.system({
  --       "sed",
  --       [[ s/^\.\/// ]],
  --     }, { stdin = job1.stdout or "" }):wait()
  --
  --     local job3 = vim.system({
  --       "tail",
  --       "-n",
  --       "+2",
  --     }, { stdin = job2.stdout or "" }):wait()
  --
  --     local job4 = vim.system({
  --       "rg",
  --       prompt
  --     }, { stdin = job3.stdout or "" }):wait()
  --
  --     return vim.split(job4.stdout or "", "\n")
  --   end,
  --   entry_maker = make_entry.gen_from_string(opts)
  -- })

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Find Folders",
    finder = one_shot_finder,
    previewer = conf.grep_previewer(opts),
    sorter = conf.file_sorter(opts)
  }):find()
end

M.setup = function()
end

M.find_folders()

return M
