require("rose-pine").setup({
  variant = "main",
  dark_variant = "main",
  highlight_groups = {
    StatusLine = { fg = "iris", bg = "iris", blend = 10 },
    StatusLineNC = { fg = "subtle", bg = "surface" },
  },
})

vim.cmd("colorscheme rose-pine")
