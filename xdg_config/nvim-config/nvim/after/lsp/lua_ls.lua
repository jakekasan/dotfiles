---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  root_markers = { { ".luarc.json", ".git", "lua" } },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      library = {
        vim.env.VIMRUNTIME,
        "${3rd}/luv/library",
        "${3rd}/busted/library",
      },
    },
  },
}
