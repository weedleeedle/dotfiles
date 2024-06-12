local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', require("telescope").extensions.picker_list.picker_list, {})
vim.keymap.set('n', '<F3>', require('telescope').extensions.file_browser.file_browser, {})

--Expand error
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})

--Quick fix
vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, {});

--Line numbers
vim.keymap.set('n', '<F2>', vim.fn.ToggleLineNumbers, {});

vim.keymap.set('n', '<C-W><C-]>', '<C-W>v<C-]>', { noremap = true, silent = true })

-- LspAttach autocommand only adds maps after language server
-- attaches to current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer mappings
        local opts = { buffer = ev.buf }
        -- jump to definition
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
        -- hover over documentation
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
        -- List implementations
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
        -- Get signature help
        vim.keymap.set('n', '<leader><C-K>', vim.lsp.buf.signature_help, opts)
        -- Jump to type definition
        vim.keymap.set('n', '<leader>gD', vim.lsp.buf.type_definition, opts)
        -- Rename symbol
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        -- get references
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
        -- format
        vim.keymap.set('n', '<leader><space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})




