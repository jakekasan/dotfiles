return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    require("dapui").setup({})
  end
}
