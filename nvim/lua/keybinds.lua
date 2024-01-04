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

