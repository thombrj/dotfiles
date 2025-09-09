return {
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
      },
      window = {
        auto_open = false
      }
    })
    vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end
}
