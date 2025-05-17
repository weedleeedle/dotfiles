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
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    capabilities = capabilities,
}

lspconfig.ts_ls.setup {
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

lspconfig.pyright.setup {
    capabilities = capabilities,
}

lspconfig.svelte.setup{}

lspconfig.gdscript.setup{}

lspconfig.cssls.setup {
    capabilities = capabilities
}

lspconfig.html.setup{}

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
        launch_scene = true,
    }
}
