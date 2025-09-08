return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({})
    require("mason-nvim-dap").setup({})
  end,
}
