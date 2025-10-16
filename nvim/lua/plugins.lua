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
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- Load color scheme early
        config = function()
        -- 5.1. Color Scheme Configuration
        require("catppuccin").setup({
            flavour = "mocha", -- Explicitly set the dark 'mocha' flavor
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            term_colors = true,
            styles = {
                comments = { "italic" },
                functions = { "bold" },
                variables = {},
            },
        })
        vim.cmd.colorscheme("catppuccin")
        end
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

    -- {{{ Search
    -- {
    --     "https://github.com/ibhagwan/fzf-lua",
    --     dependencies = {
    --         "https://github.com/elanmed/fzf-lua-frecency.nvim",
    --     },
    --     event = "VeryLazy",
    --     config = function()
    --         require("fzf-lua").setup({
    --             "max-perf",
    --             winopts = {
    --                 height = 0.5,
    --                 width = 1,
    --                 row = 1,
    --             },
    --         })
    --         require("fzf-lua").register_ui_select()
    --         require("fzf-lua-frecency").setup({
    --             display_score = false,
    --         })
    --     end,
    -- },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
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
        -- Map leader + f (or Space + f) to find files, similar to VSCode's search
        map("n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find Files (Fuzzy Search)" })
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
    -- TODO refactor when Tree-sitter is stable and merged to nvim core
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4767
    {
        "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "cue",
                    "go",
                    "hcl",
                    "kdl",
                    "nix",
                    "puppet",
                    "python",
                    "rust",
                    "terraform",
                    "tsx",
                    "typescript",
                    "vimdoc",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
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
                direction = "horizontal",
                shade_terminals = true,
                start_in_insert = true,
                float_opts = {
                    border = "curved",
                },
            })
        end,
    },
    {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree", -- Use cmd for lazy loading
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      -- 5.3. Neo-tree (File Explorer) Configuration
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 35,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_hidden = false,
          }
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = "✚",
              modified = "",
              deleted = "✖",
              untracked = "⋆",
            },
          },
        }
      })
    end,
  },
    -- }}}
})
