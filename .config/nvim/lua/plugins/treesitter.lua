return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        ensure_installed = {
          "json",
          "c_sharp",
          "terraform",
          "lua",
          "yaml"
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          }
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v'
          },
          include_surrounding_whitespace = true,
        }
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "af", function()
        select("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        select("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        select("@local.scope", "locals")
      end)
    end
  }
}
