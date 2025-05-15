local utils = require("jake.utils")

local M = {}

function M.on_attach(_, bufnr)
  local nmap = utils.make_map("n", {buffer = bufnr})
  local imap = utils.make_map("i", {buffer = bufnr})

  nmap("gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
  nmap("gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
  nmap("gi", function() vim.lsp.buf.implementation() end, "[G] List [i]mplementation")
  nmap("K", function() vim.lsp.buf.hover() end, "Hover [K]??")
  nmap("]d", function() vim.diagnostic.goto_next() end, "Next [d] diagnostic")
  nmap("[d", function() vim.diagnostic.goto_prev() end, "Previous [d] diagnostic")
  ---@diagnostic disable-next-line: missing-parameter
  -- nmap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
  -- nmap("<leader>vd", function() vim.diagnostic.open_float() end)
  nmap("<leader>vca", function() vim.lsp.buf.code_action() end)
  nmap("<leader>vrr", function() vim.lsp.buf.references() end)
  nmap("<leader>vrn", function() vim.lsp.buf.rename() end)
  imap("<C-h>", function() vim.lsp.buf.signature_help() end, "Signature [h]elp")
end

return M
