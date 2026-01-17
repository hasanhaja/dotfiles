return {
  { "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    opts_extend = {
      "ensure_installed",
    },
    opts = {
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      highlight = { enable = true },
      ensure_installed = {
        "bash",
        "diff",
        "vimdoc",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "json",
        "html",
        "markdown",
        "markdown_inline",
        "astro",
        "json",
        "toml",
        "yaml",
        "xml",
        "c",
        "lua",
        "luadoc",
        "luap",
        "elixir",
        "heex",
      },
    },
    config = function()
      vim.filetype.add({
        extension = {
          webc = 'webc'
        },
        filename = {['.webc'] = 'html'}
      })

      vim.treesitter.language.register('html', 'webc')
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end)
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "mbbill/undotree",
    lazy = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
  },
  -- Completions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require('cmp')
      local cmp_select = {behavior = cmp.SelectBehavior.Select}

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
          {name = 'path'},
          {name = 'buffer'},
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = nil,
          ['<S-Tab>'] = nil,
        }),
      })
    end
  },
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            }
          }
        }
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            'lua_ls',
            'gopls',
            'html',
            'elixirls',
            'eslint',
            'zls',
            'bashls',
            'jsonls',
            'cssls',
          }
        },
      },
    },
    config = function()
      -- Reference: https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/lsp.lua

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      end

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
          vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
          vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
          vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        end,
      })

      -- Diagnostics
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
          },
        },
      })
    end
  },
}
