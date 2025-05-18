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
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { "nvim-dap-ui" },
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  lazy = false,
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("lspconfig").basedpyright.setup({
      on_attach=on_attach,
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict"
          }
        }
      }
    })

    require("lspconfig").cssls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
    })

    require'lspconfig'.djlsp.setup{}

    require("lspconfig").dockerls.setup({})

    require("lspconfig").gopls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
    })


    require("lspconfig").hls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
      cmd = { "haskell-language-server-wrapper", "--lsp" }
    })

    require("lspconfig").intelephense.setup({
      on_attach=on_attach,
      capabilities = capabilities,
      root_dir=function()
        return vim.loop.cwd()
      end
    })

    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    require("lspconfig").r_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    require'lspconfig'.terraformls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    require("lspconfig").ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    require('lspconfig').yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
}

