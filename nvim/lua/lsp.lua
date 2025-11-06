-- local vim.lsp.enable = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable("rust_analyzer")

vim.lsp.config("rust_analyzer",{
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
})

vim.lsp.enable("omnisharp")

vim.lsp.config("omnisharp", {
    cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    capabilities = capabilities,
})

vim.lsp.enable("ts_ls")

vim.lsp.config("ts_ls", {
    capabilities = capabilities
})

vim.lsp.enable("lua_ls")

vim.lsp.config("lua_ls", {
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
})

vim.lsp.enable("pyright")

vim.lsp.config("pyright", {
    capabilities = capabilities,
})

vim.lsp.enable("svelte")

vim.lsp.config("svelte", {})

vim.lsp.enable("gdscript")

vim.lsp.config("gdscript", {})

vim.lsp.enable("cssls")

vim.lsp.config("cssls", {
    capabilities = capabilities
})

vim.lsp.enable("html")

vim.lsp.config("html", {})

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

vim.lsp.enable("clangd")

vim.lsp.config("clangd", {})
