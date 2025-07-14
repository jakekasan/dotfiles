return {
  "saghen/blink.cmp",
  version="1.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
    },

    signature = { enabled = true },

    enabled = function()
      return vim.b.completion ~= false and vim.bo.filetype ~= "TelescopePrompt"
    end,

    completion = {
      menu = {
        draw = {
          columns = {
            {"label", "label_description", gap = 1},
            {"kind_icon", "kind"}
          }
        },

      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
          scrollbar = true
        }
      },
      accept = {
        auto_brackets = {
          enabled = false
        }
      }
    },

    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer"
      },
    },

  },
}
