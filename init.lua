vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = ""
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'

-- Remap
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Package Manager 
local ok, MiniDeps = pcall(require, 'mini.deps')
if not ok then
  vim.notify('[WARN] mini.deps module not found', vim.log.levels.WARN)
  return
end
MiniDeps.setup()

-- Theme
MiniDeps.add("folke/tokyonight.nvim")
require("tokyonight").setup({ style = "moon", transparent = true, })
vim.cmd.colorscheme("tokyonight")

-- LSP
MiniDeps.add('neovim/nvim-lspconfig')
require('mini.snippets').setup()
require('mini.completion').setup()
require('mini.comment').setup()
require('mini.files').setup()
require('mini.pick').setup()
vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end, { desc = "File explorer" })
vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end, { desc = "Live grep" })

-- Language server
-- npm i -g @vtsls/language-server @vue/language-server typescript @vue/typescript-plugin
vim.lsp.enable({'gopls', 'vtsls', 'vue_ls'})
