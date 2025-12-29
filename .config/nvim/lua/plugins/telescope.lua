return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "/[Bb]in/",
            "/[Oo]bj/",
            ".git/",
            ".nuget/"
          },
          layout_config = {
            prompt_position = 'top'
          },
          path_display = { "truncate = 3" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',        -- Add this flag
            '--no-ignore-vcs', -- Optional: Also search files ignored by git
          }
        },
        pickers = {
          find_files = {
            sorting_strategy = 'ascending',
            hidden = true,
            follow = true
          }
        },
        colorscheme = {
          enable_preview = true
        },
        preview = { treesitter = false }
      })

      telescope.load_extension("fzf")
      local keymap = vim.keymap

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    end
  },
}
