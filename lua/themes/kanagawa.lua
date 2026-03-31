vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
})

require("kanagawa").setup({
  transparent = true,
  colors = {
    theme = { all = { ui = { bg_gutter = "none" } } },
  },
})

vim.cmd.colorscheme("kanagawa")

vim.cmd("highlight TelescopeBorder guibg=none")
vim.cmd("highlight TelescopeTitle guibg=none")

-- lualine
require('lualine').setup()
