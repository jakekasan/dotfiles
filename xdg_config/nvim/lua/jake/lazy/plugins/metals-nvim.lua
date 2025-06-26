local utils = require("jake.utils")

local function on_attach(_, bufnr)
  local nmap = utils.make_map("n", {buffer = bufnr})
  local imap = utils.make_map("i", {buffer = bufnr})

  nmap("gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
  nmap("gd", function() vim.lsp.buf.definition() end, "[G]o to [d]efinition")
  nmap("gi", function() vim.lsp.buf.implementation() end, "[G] List [i]mplementation")
  nmap("K", function() vim.lsp.buf.hover() end, "Hover [K]??")
  nmap("]d", function() vim.diagnostic.goto_next() end, "Next [d] diagnostic")
  nmap("[d", function() vim.diagnostic.goto_prev() end, "Previous [d] diagnostic")
  nmap("<leader>vca", function() vim.lsp.buf.code_action() end)
  nmap("<leader>vrr", function() vim.lsp.buf.references() end)
  nmap("<leader>vrn", function() vim.lsp.buf.rename() end)
  imap("<C-h>", function() vim.lsp.buf.signature_help() end, "Signature [h]elp")
end

return {
  "scalameta/nvim-metals",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = on_attach
    metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
