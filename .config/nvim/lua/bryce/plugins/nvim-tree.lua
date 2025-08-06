return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive"
        },
        view = {
          width = 30
        },
        filters = {
          dotfiles = true
        }
      })
      -- settings for nvim tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")
      vim.keymap.set('n', '<leader>ft', function()
        if vim.fn.bufname():match 'NvimTree_' then
          vim.cmd.wincmd 'p'
        else
          nvimtree.find_file(true)
        end
      end, { desc = 'nvim-tree: toggle' })
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            show_hidden_count = true,
            hide_doftifles = false,
            hide_gitignored = false

          },
          follow_current_file = {
            enabled = true
          }
        }
      })
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end
  }
}
