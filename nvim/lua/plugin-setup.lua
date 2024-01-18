require("telescope").setup {
    extensions = {
        picker_list = {},
    }
}
require("telescope").load_extension "file_browser"
require("telescope").load_extension "picker_list"

require('lualine').setup {
    options = { theme = "ayu_mirage" }
}

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = 'buffer' },
        { name = 'async_path' },
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})

require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use
        -- **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})
