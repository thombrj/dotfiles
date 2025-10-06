return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive"
        },
        view = {
          width = 30
        },
        disable_netrw = true,
        filters = {
          dotfiles = false
        },
        update_focused_file = {
          enable = true,
        }
      })
      -- settings for nvim tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<A-n>", ":NvimTreeToggle<CR>")
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
}
