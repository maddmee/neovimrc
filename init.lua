-- ============================================================================
-- 0. Bootstrap & Environment
-- ============================================================================
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.npm-global/bin")
vim.g.loaded_netrw, vim.g.loaded_netrwPlugin = 1, 1 -- Kill netrw

local path_package = vim.fn.stdpath('data') .. '/site'
local deps_path = path_package .. '/pack/deps/start/mini.nvim'

if not vim.uv.fs_stat(deps_path) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com', deps_path })
  vim.cmd('packadd mini.nvim | helptags ALL')
end

vim.cmd('packadd mini.nvim')
local MiniDeps = require('mini.deps')
MiniDeps.setup()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- ============================================================================
-- 1. Plugin Registration (Immediate)
-- ============================================================================
now(function()
  add('folke/tokyonight.nvim')
  add('neovim/nvim-lspconfig')
  add({ source = 'nvim-treesitter/nvim-treesitter', checkout = 'main' })
  add('JoosepAlviste/nvim-ts-context-commentstring')
  
  vim.cmd('packadd tokyonight.nvim')
  vim.cmd('packadd nvim-lspconfig')
  vim.cmd('packadd nvim-treesitter')
  vim.cmd('packadd nvim-ts-context-commentstring')

  -- Transparency Restored
  require('tokyonight').setup({ style = 'moon', transparent = true })
  vim.cmd.colorscheme('tokyonight')
end)

-- ============================================================================
-- 2. THE VUE FIX: Global Option Override (Neovim 0.11 Native)
-- ============================================================================
-- 1. Ensure global commentstring is empty (REQUIRED for dynamic switching)
vim.opt.commentstring = ""

-- 2. Improved Global Override for 0.11
now(function()
  -- ... (your other add calls)
  add('JoosepAlviste/nvim-ts-context-commentstring')
  vim.cmd('packadd nvim-ts-context-commentstring')

  local get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    if option == "commentstring" then
      -- Priority 1: Tree-sitter context
      local ok, tsc = pcall(require, "ts_context_commentstring.internal")
      if ok then
        local calculated = tsc.calculate_commentstring()
        if calculated then return calculated end
      end
      
      -- Priority 2: Manual Context Check (The "No-Fail" fallback)
      if filetype == 'vue' then
        local node = vim.treesitter.get_node()
        if node then
          local type = node:type()
          if type:find("script") then return "// %s" end
          if type:find("style") then return "/* %s */" end
        end
        return "<!-- %s -->"
      end
    end
    return get_option(filetype, option)
  end
end)

-- 3. Simplified mini.comment
later(function()
  require('mini.comment').setup({})
end)

-- ============================================================================
-- 3. LSP Setup (0.11 API - vue_ls)
-- ============================================================================
now(function()
  vim.lsp.enable('vue_ls', 'gopls', 'vtsls')

  vim.lsp.config('vtsls', {
    filetypes = { 'javascript', 'typescript', 'vue' },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.expand("~/.npm-global/lib/node_modules/@vue/language-server"),
              languages = { "vue" },
            },
          },
        },
      },
    },
  })
end)

-- ============================================================================
-- 4. Treesitter & Basic UI
-- ============================================================================
later(function()
  require('nvim-treesitter').setup({
    ensure_installed = { "vue", "typescript", "javascript", "html", "css", "lua" },
    highlight = { enable = true },
  })

  require('ts_context_commentstring').setup({ enable_autocmd = false })
  require('mini.comment').setup({}) -- Inherits from global override
end)

-- ============================================================================
-- 5. Options, Remaps & Nav
-- ============================================================================
now(function()
  vim.g.mapleader = " "
  vim.o.number, vim.o.relativenumber = true, true
  vim.o.tabstop, vim.o.shiftwidth = 4, 4
  vim.o.smartcase, vim.o.ignorecase = true, true
  vim.o.signcolumn = 'yes'

  local k = vim.keymap.set
  k("v", "J", ":m '>+1<CR>gv=gv")
  k("v", "K", ":m '<-2<CR>gv=gv")
  k({ "n", "v" }, "<leader>y", [["+y]])
  k("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
end)

later(function()
  require('mini.files').setup()
  vim.keymap.set('n', '<leader>e', function() if not MiniFiles.close() then MiniFiles.open() end end)
  require('mini.pick').setup()
  require('mini.icons').setup()
  require('mini.completion').setup()
  require('mini.git').setup()
  require('mini.cmdline').setup()
  require('mini.snippets').setup()
end)

