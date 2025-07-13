return {
  cmd = { "lua-language-server" },
  root_markers = { { ".luarc.json", ".git", "lua" } },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
