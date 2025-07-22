local utils = require("jake.utils")

vim.lsp.enable({
  "astro",
  "basedpyright",
  "cssls",
  "denols",
  "gopls",
  "html-lsp",
  "intelephense",
  "jdtls",
  "jsonls",
  "lua_ls",
  "ruff",
  "rust_analyzer",
  "templ",
  "ts_ls",
  "yamlls"
})

vim.lsp.enable("pyright", false)
vim.lsp.enable("ty", false) -- not ready

local function add_mappings(_, bufnr)
  local nmap = utils.make_map("n", { buffer = bufnr })
  local imap = utils.make_map("i", { buffer = bufnr })

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

-- TODO: move elsewhere at some point
local format_on_save = true

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
      return
    end

    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    -- TODO: move this somewhere else, too
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_user_command("FormatFile", function()
        vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
      end, { desc = "Run formatting using compatible client" })

      local lsp_group = vim.api.nvim_create_augroup("JakeLSPStuff", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = event.buf,
        group = lsp_group,
        callback = function()
          if format_on_save then
            vim.cmd("FormatFile")
          else
          end
        end
      })
    end

    vim.api.nvim_create_user_command("ToggleFormatOnSaveOn", function()
      format_on_save = true
    end, { desc = "Turn formatting on save on" })

    vim.api.nvim_create_user_command("ToggleFormatOnSaveOff", function()
      format_on_save = false
    end, { desc = "Turn formatting on save off" })

    vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
      format_on_save = not format_on_save
    end, { desc = "Toggle formatting on save" })

    add_mappings(_, event.buf)
  end
})

--- WTF
vim.cmd("set completeopt+=noselect")
