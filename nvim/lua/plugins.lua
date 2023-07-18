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

    use 'flazz/vim-colorschemes'
    use 'junegunn/goyo.vim'
    use 'itchyny/lightline.vim'
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
        'neovim/nvim-lspconfig'
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
 
end)


