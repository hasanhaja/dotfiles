vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = .85,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = true
    vim.wo.number = true
    vim.wo.rnu = true
    ColorMyPencils()
end)


vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup {
        window = {
            width = .85,
            options = { }
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    ColorMyPencils()
end)
