vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 8
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'
vim.g.mapleader = vim.keycode('<Space>')

-- Remap
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Package manager 
-- git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim
local ok, MiniDeps = pcall(require, 'mini.deps')
if not ok then
  vim.notify('[WARN] mini.deps module not found', vim.log.levels.WARN)
  return
end
MiniDeps.setup()
-- Theme
MiniDeps.add("folke/tokyonight.nvim")
require("tokyonight").setup({ style = "storm", transparent = true, })
vim.cmd.colorscheme("tokyonight")
-- LSP
MiniDeps.add('neovim/nvim-lspconfig')
require('mini.snippets').setup()
require('mini.completion').setup()
require('mini.comment').setup()
require('mini.files').setup()
vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', {desc = 'File explorer'})
-- Language server
-- go install golang.org/x/tools/gopls@latest
vim.lsp.enable({'gopls'})
-- For rust run: rustup component add rust-analyzer
-- then add the rust_analyzer next to gopls
