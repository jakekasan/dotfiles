return {
  "saghen/blink.cmp",
  version="1.*",

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono"
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
        auto_show = function (ctx)
          return ctx.mode ~= "cmdline"
        end
      },
      documentation = {
        auto_show = true,
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
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
