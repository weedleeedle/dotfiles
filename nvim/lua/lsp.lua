local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.rust_analyzer.setup{
    capabilites = capabilities,
    --[[
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = {"all", "test"}
            }
        }
    }
    --]]
}

lspconfig.omnisharp.setup {
    cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
    enable_editorconfig_support = true,
    --enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    capabilities = capabilities,
}

lspconfig.tsserver.setup {
    capabilities = capabilities
}

lspconfig.lua_ls.setup {
    -- Lots of settings for NeoVIM since that's what I mostly use vim for.
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities
}
