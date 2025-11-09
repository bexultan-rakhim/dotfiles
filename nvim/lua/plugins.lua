local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
    -- {{{ UI
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("solarized-osaka").setup({
                  transparent = false, -- Enable this to disable setting the background color
            })
            vim.cmd[[colorscheme solarized-osaka]]
        end,
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    -- }}}
    -- {{{ Remote
    { "christoomey/vim-tmux-navigator" }, -- Seamless movement between Neovim and Tmux panes
    {
        "amitds1997/remote-nvim.nvim",
        config = function()
        -- Initializes the plugin. Use the command :RemoteNvim <user@host> <path> to connect.
        require("remote-nvim").setup({})
        end
    },
    -- }}}
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        ["<C-j>"] = require('telescope.actions').move_selection_next,
                    },
                },
            }
        })
        end,
    },
    -- {
    --     'nvim-telescope/telescope-media-files.nvim',
    --     require('telescope').load_extension('media_files'),
    -- },
    { "https://github.com/MagicDuck/grug-far.nvim", lazy = true },
    -- }}}

    -- {{{ File manager
    {
        "https://github.com/stevearc/oil.nvim",
        cmd = "Oil",
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, _)
                        return name == ".."
                    end,
                },
            })
        end,
    },
    -- }}}
    {
        "mason-org/mason.nvim",
        opts = {}
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            
            vim.lsp.enable("clangd")
            vim.lsp.config("clangd", {
                capabilities = capabilities
            })
            vim.lsp.enable("rust-analyzer")
            vim.lsp.config("rust-analyzer", {
                cmd = { "rust-analyzer" },
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            })
            vim.lsp.enable("nixd")
            vim.lsp.config("nixd", {
                cmd = { "nixd"},
                capabilities = capabilities,
                settings = {
                    ["nixd"] = {
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                    },
                },
            })
            vim.keymap.set("n", "I", vim.lsp.buf.hover, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip", 
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer", 
            "hrsh7th/cmp-path",  
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            return {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
            }
        end,
    },
    {
        "https://github.com/windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    -- }}}

    -- {{{ Git
    { "https://github.com/tpope/vim-fugitive", cmd = "Git" },

    {
        "https://github.com/nvim-mini/mini.diff",
        event = "VeryLazy",
        config = function()
            require("mini.diff").setup({})
        end,
    },
    -- }}}

    -- {{{ Motions
    {
        "https://github.com/folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("flash").setup({
                search = {
                    wrap = false,
                },
                modes = {
                    search = {
                        enabled = true,
                    },
                },
            })
        end,
    },

    {
        "https://github.com/nvim-mini/mini.surround",
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({})
        end,
    },
    -- }}}

    -- {{{ Miscellaneous
    { "https://github.com/farmergreg/vim-lastplace", event = "BufReadPost" },
    { "https://github.com/echasnovski/mini.bufremove", lazy = true },

    {
        "https://github.com/tpope/vim-sleuth",
        event = "VeryLazy",
        config = function()
            vim.cmd("silent Sleuth")
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<C-t>]],
                direction = "float",
                shade_terminals = true,
                start_in_insert = true,
                float_opts = {
                    border = "curved",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"c", "cpp"},
                auto_install = true,
                highlight = {enable = true },
                indent = { enable = true },

            })
        end
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    }
    -- }}}
})
