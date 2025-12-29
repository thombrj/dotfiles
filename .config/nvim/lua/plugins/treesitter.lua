return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
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
        auto_install = false,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          }
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            }
          }
        }
      })

      local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      treesitter_parser_config.powersehll = {
        install_info = {
          url = "~/.local/share/nvim/custom/tree-sitter-powershell/",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammer = false,
        },
        filetype = "ps1"
      }
    end,
  },
}
