-- ============================================================================
-- Bootstrap mini.nvim
local path_package = vim.fn.stdpath('data') .. '/site'
local deps_path = path_package .. '/pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(deps_path) then
  vim.cmd('echo "Installing mini.nvim (for mini.deps)..." | redraw')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim',
    deps_path,
  })
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed mini.nvim" | redraw')
end

vim.cmd('packadd mini.nvim')

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

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- ============================================================================
-- Package Manager (mini.deps)
local ok, MiniDeps = pcall(require, 'mini.deps')
if not ok then
  vim.notify('[WARN] mini.deps module not found (is mini.nvim installed?)', vim.log.levels.WARN)
  return
end

MiniDeps.setup({
  -- Keep plugins under the same "site" directory we used for bootstrapping mini.nvim
  path = { package = path_package },
})

local add = MiniDeps.add

-- ============================================================================
-- Theme
add({ source = "folke/tokyonight.nvim" })
require("tokyonight").setup({
  style = "moon",
  transparent = true,
})
vim.cmd.colorscheme("tokyonight")

-- ============================================================================
-- LSP + Mini modules
add({ source = "neovim/nvim-lspconfig" })

require('mini.snippets').setup()
require('mini.completion').setup()
require('mini.comment').setup()
require('mini.files').setup()
require('mini.pick').setup()

vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end, { desc = "File explorer" })
vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end, { desc = "Live grep" })

-- ============================================================================
-- Language servers
-- npm i -g @vtsls/language-server @vue/language-server typescript @vue/typescript-plugin
vim.lsp.enable({ 'gopls', 'vtsls', 'vue_ls' })
