local M = {}

local function_queries = { [[
(function_definition
  name: (identifier)
  body: (block
          .
          (expression_statement
            (string
              (string_start)
              (string_content)
              (string_end)) @docstring)))
]], [[
(class_definition
  name: (identifier)
  body: (block
          .
          (expression_statement
            (string
              (string_start)
              (string_content)
              (string_end)) @dosctring)))
]]
}

function M.find_docstrings()
  for _, query in ipairs(function_queries) do
    vim.notify(query)
  end
end

local function test()
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {
    "def foo():",
    [[    """foobarbaz"""]],
    "    return 'foo!'",
    "",
    "",
    "",
    "def bar():",
    [[    """wutthis"""]],
    [[    """another"""]],
    "    return 'bar!'",
    "",
    "class Foo:",
    [[    """class thing"""]],
    "    a: int",
    "    b: int",
    ""
  })

  local tree = vim.treesitter.get_parser(buffer, "python"):parse()[1]
  local query = vim.treesitter.query.parse("python", function_queries[1])
  for _, node, _ in query:iter_captures(tree:root(), 0) do
    vim.print({ node:type(), vim.treesitter.get_node_text(node, buffer) })
  end
end

test()

return M
