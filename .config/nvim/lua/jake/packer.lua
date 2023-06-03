-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use "folke/tokyonight.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = (
                require('nvim-treesitter.install')
                .update({ with_sync = true})
            )
            ts_update()
        end,
    }

    use "nvim-treesitter/playground"

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(function(...) vim.cmd(...) end, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-buffer'}, -- Required
            {'hrsh7th/cmp-path'}, -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {"hrsh7th/cmp-nvim-lua"},
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {
            {"nvim-telescope/telescope-live-grep-args.nvim"},
            {'nvim-lua/plenary.nvim'}
        },
        config = function ()
            require("telescope").load_extension("live_grep_args")
        end
    }

    use {
        "nvim-tree/nvim-tree.lua",
        requires = {"nvim-tree/nvim-web-devicons"},
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { "tpope/vim-fugitive" }

    use { "folke/neodev.nvim" }
end)

