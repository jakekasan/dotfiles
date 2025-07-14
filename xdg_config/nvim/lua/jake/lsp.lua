local utils = require("jake.utils")

vim.lsp.enable({
  "basedpyright",
  "cssls",
  "denols",
  "gopls",
  "jdtls",
  "jsonls",
  "lua_ls",
  "ts_ls"
})

vim.lsp.enable("pyright", false)
vim.lsp.enable("ty", false) -- not ready

local function add_mappings(_, bufnr)
  local nmap = utils.make_map("n", {buffer = bufnr})
  local imap = utils.make_map("i", {buffer = bufnr})

  nmap("gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
  nmap("gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
  nmap("gi", function() vim.lsp.buf.implementation() end, "[G] List [i]mplementation")
  nmap("K", function() vim.lsp.buf.hover() end, "Hover [K]??")
  nmap("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next [d] diagnostic")
  nmap("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous [d] diagnostic")
  nmap("<leader>vca", function() vim.lsp.buf.code_action() end)
  nmap("<leader>vrr", function() vim.lsp.buf.references() end)
  nmap("<leader>vrn", function() vim.lsp.buf.rename() end)
  imap("<C-h>", function() vim.lsp.buf.signature_help() end, "Signature [h]elp")
end


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
      return
    end

    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    -- end

    add_mappings(_, event.buf)
  end
})

--- WTF
vim.cmd("set completeopt+=noselect")

