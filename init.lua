-- ============================================================================
-- Bootstrap & Environment

vim.env.PATH = table.concat({
  vim.env.PATH,
  vim.fn.expand("~/.npm-global/bin"),
}, ":")

-- disable netrw early
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- paths
local data = vim.fn.stdpath("data")
local site = vim.fs.joinpath(data, "site")
local mini_path = vim.fs.joinpath(site, "pack", "deps", "start", "mini.nvim")

vim.opt.runtimepath:append(site)

-- bootstrap mini.nvim (Neovim 0.12 style)
if not vim.uv.fs_stat(mini_path) then
  vim.notify("Installing mini.nvim...", vim.log.levels.INFO)

  vim.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }):wait()

  vim.cmd("packadd mini.nvim")
end

vim.cmd("packadd mini.nvim")

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
-- mini.deps

local MiniDeps = require("mini.deps")
MiniDeps.setup()

-- ============================================================================
-- Plugins

MiniDeps.add("folke/tokyonight.nvim")
MiniDeps.add("neovim/nvim-lspconfig")

-- mini modules
require("mini.files").setup()
require("mini.pick").setup()
require("mini.icons").setup()
require("mini.git").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

-- UI
vim.cmd.colorscheme("tokyonight")

-- file explorer
vim.keymap.set("n", "<leader>e", function()
  require("mini.files").open()
end)

-- picker
vim.keymap.set("n", "<leader>ff", function()
  require("mini.pick").builtin.files()
end)
vim.keymap.set("n", "<leader>fb", function()
  require("mini.pick").builtin.buffers()
end)
vim.keymap.set("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live()
end)

-- ============================================================================
-- LSP

-- install
local function ensure(cmd, install_cmd)
  if vim.fn.executable(cmd) == 0 then
    vim.notify("Installing " .. cmd)
    vim.system(install_cmd):wait()
  end
end

ensure("gopls", {
  "go", "install", "golang.org/x/tools/gopls@latest",
})

ensure("vtsls", {
  "npm", "i", "-g", "@vtsls/language-server", "typescript",
})

ensure("vue-language-server", {
  "npm", "i", "-g", "@vue/language-server",
})

-- enable
vim.lsp.enable({
  "gopls",
  "vtsls",
  "vue_ls",
})
