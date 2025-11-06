require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "%.png",
            "%.jpg",
        },
    },
    extensions = {
        picker_list = {},
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "-L" },
        }
    }
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "picker_list"

require('lualine').setup {
    options = { theme = "ayu_mirage" },
    sections = {
        lualine_x = {
            -- Show "recording @.."
            {
                -- require("noice").api.statusline.mode.get,
                -- cond = require("noice").api.statusline.mode.has,
            }
        }
    }
}

local cmp = require('cmp')
---@diagnostic disable-next-line: redundant-parameter
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
    },
    completion = {}
})

local dap = require("dap")
dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
}

dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true
    },
}

vim.api.nvim_create_user_command("Breakpoint", "lua require'dap'.toggle_breakpoint()", {})
vim.api.nvim_create_user_command("Continue", "lua require'dap'.continue()", {})
vim.api.nvim_create_user_command("StepOver", "lua require'dap'.step_over()", {})
vim.api.nvim_create_user_command("StepInto", "lua require'dap'.step_into()", {})
vim.api.nvim_create_user_command("REPL", "lua require'dap'.repl.open()", {})

require("aerial").setup({
    on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle! left<CR>")

--[[
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
})--]]
