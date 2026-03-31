vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-d>"] = actions.delete_buffer,
      },
      n = {
        ["<C-d>"] = actions.delete_buffer,
      },
    },
  },
})

function SearchClasses()
    builtin.lsp_dynamic_workspace_symbols({
        symbols = { "Class" },
        prompt_title = "Search Classes",
    })
end

function SearchFunctions()
    builtin.lsp_dynamic_workspace_symbols({
        symbols = { "Function", "Method" },
        prompt_title = "Search Functions",
    })
end

function SearchVariables()
    builtin.lsp_dynamic_workspace_symbols({
        symbols = { "Variable", "Constant" },
        prompt_title = "Search Variables",
    })
end

vim.keymap.set("n", "<leader>ff", builtin.git_files)
vim.keymap.set("n", "<leader>fa", builtin.find_files)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fk", builtin.keymaps)
-- vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>sf', SearchFunctions, {})
-- vim.keymap.set('n', '<leader>sc', SearchClasses, {})
-- vim.keymap.set('n', '<leader>sv', SearchVariables, {})
-- vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, {})
-- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sq', builtin.quickfix, {})
