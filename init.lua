vim.loader.enable()

-- ============================================================================
-- Basic Options

vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.signcolumn = "yes"

-- ============================================================================
-- Keymaps

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", "<gv")
vim.keymap.set("v", "L", ">gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- ============================================================================
-- Plugins

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mason").setup()
require("mini.completion").setup()
require("mini.files").setup()
require("mini.pick").setup()
require("mini.icons").setup()
require("mini.git").setup()
require("mini.statusline").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- theme
require("tokyonight").setup({ transparent = true })
vim.cmd.colorscheme("tokyonight")

-- file explorer
vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end)

-- picker
vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files() end)
vim.keymap.set("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end)
vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end)
