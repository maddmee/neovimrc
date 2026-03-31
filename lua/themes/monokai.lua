vim.pack.add({
	{ src = "https://github.com/loctvl842/monokai-pro.nvim" },
})

require("monokai-pro").setup({
  transparent_background = true,

  override_palette = function(filter)
    return {
      dark2 = "#101014",
      dark1 = "#16161E",
      background = "#1A1B26",
      text = "#eeeddd",
      accent1 = "#f2798c",
      accent2 = "#7aa2f7",
      accent3 = "#e0af68",
      accent4 = "#9ece6a",
      accent5 = "#0DB9D7",
      accent6 = "#9d7cd8",
      dimmed1 = "#737aa2",
      dimmed2 = "#787c99",
      dimmed3 = "#363b54",
      dimmed4 = "#363b54",
      dimmed5 = "#16161e",
    }
  end,
})

vim.cmd.colorscheme("monokai-pro")
vim.opt.fillchars = { eob = " " }

-- mini.files tweaks
vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "MiniFilesNormalNC", { bg = "none", fg = "#bbbbbb" })
vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = "none", fg = "#333333" })
vim.api.nvim_set_hl(0, "MiniFilesCursorLine", { bg = "#19181a", fg = "none" })
vim.api.nvim_set_hl(0, "MiniFilesDirectory", { bg = "none", fg = "#dbb063" })
vim.api.nvim_set_hl(0, "MiniFilesTitle", { bg = "#946b21", fg = "#000000" })
vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { bg = "#946b21", fg = "#000000" })

