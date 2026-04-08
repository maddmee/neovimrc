require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "vtsls", "vue_ls", "css_variables" },
    automatic_installation = true,
})

local vue_plugin_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("vtsls", {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_plugin_path,
                        languages = { "vue" },
                    },
                },
            },
        },
    },
})

vim.lsp.config("vue_ls", {})

vim.lsp.config("css_variables", {
    filetypes = { "css", "scss", "less", "vue", "javascriptreact", "typescriptreact" },
})

vim.lsp.enable({ "vtsls", "vue_ls", "css_variables" })
