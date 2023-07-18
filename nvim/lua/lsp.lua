local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.rust_analyzer.setup{
    capabilites = capabilities
}

lspconfig.omnisharp.setup {
    cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
    enable_editorconfig_support = true,
    --enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
}
