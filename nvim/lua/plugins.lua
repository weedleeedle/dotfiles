-- Bootstrap Packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function ()
            local ts_update = require('nvim-treesitter.install').update({with_sync = true})
            ts_update()
        end,
        ensure_installed = { 'gdscript' }
    }
    use 'flazz/vim-colorschemes'
    use 'junegunn/goyo.vim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt=true}
    }
    -- Replaced with telescope.
    --use 'scrooloose/nerdtree'
    use 'tpope/vim-surround'
    use 'scrooloose/nerdcommenter'
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'lambdalisue/suda.vim'
    use 'lewis6991/gitsigns.nvim'
    use {
        'kkoomen/vim-doge',
        run = ":call doge#install()"
    }

    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    }
    use {
        'OliverChao/telescope-picker-list.nvim'
    }
    use {
        'hrsh7th/vim-vsnip'
    }
    use {
        'hrsh7th/cmp-nvim-lsp'
    }
    use {
        'hrsh7th/cmp-buffer'
    }
    use {
        -- 'hrsh7th/cmp-path'
        'FelipeLema/cmp-async-path'
    }
    use {
        'hrsh7th/nvim-cmp'
    }
    use {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateRight",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "", "<c-h> <cmd>TmuxNavigateLeft<cr>" },
            { "", "<c-j> <cmd>TmuxNavigateDown<cr>" },
            { "", "<c-k> <cmd>TmuxNavigateUp<cr>" },
            { "", "<c-l> <cmd>TmuxNavigateRight<cr>" },
        },
    }
    use {
        "mechatroner/rainbow_csv",
    }
    use {
        "mfussenegger/nvim-dap",
    }

    use {
        "epwalsh/obsidian.nvim",
        tag = "*", -- recommended, use latest release instead of latest commit
        requires = {
            -- Required
            "nvim-lua/plenary.nvim",
            -- Optional
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "personal",
                        path = "~/obsidian/"
                    }
                },
                daily_notes = {
                    folder = "Daily",
                    date_format = "%Y/%m/%Y-%m-%d",
                    template = "Daily.md",
                    default = require("obsidian").defaults.daily_notes
                },
                templates = {
                    folder = "00 System/Templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    default = require("obsidian").defaults.templates
                }
            })
        end,
    }
    use {
        "vim-scripts/vim-auto-save",
    }
    --[[
    use {
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
    --]]

    -- Automatically set up your configuration after cloning packer.nvim
    -- (bootstrap)
    -- KEEP THIS AT THE END
    if packer_bootstrap then
        require('packer').sync()
    end
end)




