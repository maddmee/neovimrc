local add = MiniDeps.add

add({ source = "https://github.com/nvim-mini/mini.nvim" })
add({ source = "https://github.com/neovim/nvim-lspconfig" })
add({ source = "https://github.com/nvim-lualine/lualine.nvim" })
add({ source = "https://github.com/mason-org/mason.nvim" })
add({ source = "https://github.com/mason-org/mason-lspconfig.nvim" })
add({ source = "https://github.com/rebelot/kanagawa.nvim" })
add({ source = "https://github.com/folke/tokyonight.nvim" })
add({ source = "https://github.com/nvim-lua/plenary.nvim" })
add({ source = "https://github.com/nvim-telescope/telescope.nvim" })
add({ source = "https://github.com/loctvl842/monokai-pro.nvim" })

require("lualine").setup()
require("mini.completion").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.files").setup()
vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end)

require("mini.monokai")
require("mini.telescope")
require("mini.lsp")
