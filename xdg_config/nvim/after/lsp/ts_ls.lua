return {
  root_dir = function (_, callback)
    local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
    local root_dir = vim.fs.root(0, { "package.json", "tsconfig.json" })
    if root_dir and deno_dir == nil then
      callback(root_dir)
    end
  end
}
