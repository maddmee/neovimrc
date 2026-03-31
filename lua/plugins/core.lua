vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mini.icons").setup()
require("mini.files").setup()
require("mini.completion").setup()
require("mini.git").setup()
require('lualine').setup()
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })
require("plugins.telescope")

vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end)
