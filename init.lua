-- ============================================================================
-- Bootstrap & Environment
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.npm-global/bin")
vim.g.loaded_netrw, vim.g.loaded_netrwPlugin = 1, 1 

local path_package = vim.fn.stdpath('data') .. '/site' 
local deps_path = path_package .. '/pack/deps/start/mini.nvim' 
if not vim.loop.fs_stat(deps_path) 
	then vim.cmd('echo "Installing mini.nvim (for mini.deps)..." | redraw')
		vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/nvim-mini/mini.nvim', deps_path, })
		vim.cmd('packadd mini.nvim | helptags ALL')
		vim.cmd('echo "Installed mini.nvim" | redraw') 
	end vim.cmd('packadd mini.nvim') 

-- ============================================================================
-- Basic Options 
vim.g.mapleader = " " 
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

-- ============================================================================ 
-- Remaps 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") 
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") 
vim.keymap.set("v", "H", "<gv") 
vim.keymap.set("v", "L", ">gv") 
vim.keymap.set("x", "<leader>p", [["_dP]]) 
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) 
vim.keymap.set("n", "<leader>y", [["+y]]) 
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) 
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) 
vim.keymap.set("n", "<leader>f", 
vim.lsp.buf.format) 

-- ============================================================================
-- Package Manager (mini.deps) 
local ok, MiniDeps = pcall(require, 'mini.deps') 
if not ok then vim.notify('[WARN] mini.deps module not found (is mini.nvim installed?)', 
	vim.log.levels.WARN) 
	return 
end 
MiniDeps.setup() 
local add = MiniDeps.add 

-- ============================================================================ -- Theme 
add('folke/tokyonight.nvim') require('tokyonight').setup({ style = 'moon', transparent = true, }) 
vim.cmd.colorscheme('tokyonight')

-- ============================================================================ 
-- LSP + Mini modules 
add('neovim/nvim-lspconfig') 
require('mini.snippets')
require('mini.completion')
require('mini.files')
vim.keymap.set('n', '<leader>e', function() require('mini.files').open() end, { desc = 'File explorer' }) 
require('mini.pick') 
vim.keymap.set('n', '<leader>ff', function()
require('mini.pick').builtin.files() end, { desc = 'Find files' }) 
vim.keymap.set('n', '<leader>fb', function() require('mini.pick').builtin.buffers() end, { desc = 'Find buffers' }) 
vim.keymap.set('n', '<leader>fg', function() require('mini.pick').builtin.grep_live() end, { desc = 'Live grep' }) 
require('mini.icons').setup() 
require('mini.git').setup() 
require('mini.cmdline').setup() 

-- ============================================================================ 
-- Language servers 
-- npm i -g @vtsls/language-server typescrpit @vue/language-server 
vim.lsp.enable({ 'gopls', 'vtsls', 'vue_ls' }) 
vim.lsp.config('vtsls', { 
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", }, 
}) 
