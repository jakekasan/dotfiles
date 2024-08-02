local M = {}

---@type table<number, boolean>
local qf_infos = {}

function M.report()
  for buf, is_open in pairs(qf_infos) do
    local msg = string.format("buf %i is open? %s", buf, is_open)
    vim.notify(msg)
  end
end

local function is_qf_buf(buf)
  return vim.api.nvim_get_option_value("filetype", { buf = buf}) == "qf"
end

local qf_augroup = vim.api.nvim_create_augroup("JakeQF", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = qf_augroup,
  callback = function(ev)
    if not is_qf_buf(ev.buf) then
      return
    end
    qf_infos[ev.buf] = true
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = qf_augroup,
  callback = function(ev)
    if not is_qf_buf(ev.buf) then
      return
    end
    qf_infos[ev.buf] = false
  end
})

return M
