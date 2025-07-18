---@type vim.lsp.Config
return {
  root_dir = function(_, callback)
    local dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
    if dir then
      return callback(dir)
    end
  end
}
