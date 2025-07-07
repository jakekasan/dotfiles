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
    { "nvim-java/nvim-java" }
  },
  lazy = false,
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("java").setup({
      spring_boot_tools = { enable = false }
    })
    local lsp = require("lspconfig")

    lsp.astro.setup({
      on_attach=on_attach,
      capabilities=capabilities
    })

    lsp.basedpyright.setup({
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

    lsp.cssls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
    })

    lsp.denols.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
    })

    lsp.djlsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.dockerls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.gopls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
    })

    lsp.gradle_ls.setup({})

    lsp.hls.setup({
      on_attach=on_attach,
      capabilities = capabilities,
      cmd = { "haskell-language-server-wrapper", "--lsp" }
    })

    lsp.intelephense.setup({
      on_attach=on_attach,
      capabilities = capabilities,
      root_dir=function()
        return vim.loop.cwd()
      end
    })

    lsp.jdtls.setup({
      on_attach=on_attach,
      capabilities=capabilities,
    })

    lsp.jsonls.setup({
      on_attach=on_attach,
      capabilities=capabilities,
    })

    lsp.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.r_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.ruby_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        tailwindCSS = {
          classFunctions = { "cva", "cx" }
        }
      }
    })

    lsp.terraformls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lsp.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lsp.util.root_pattern("package.json"),
      single_file_support = false
    })

    lsp.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
}

