return {
  "nvim-tree/nvim-tree.lua",
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
      },
      update_focused_file = {
        enable = true
      },
    })

    -- settings for nvim tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

--    function toggle_nvimtree()
--      if vim.fn.bufname():match 'NvimTree_' then
--        vim.cmd.wincmd 'p'
--      else
--        vim.cmd('NvimTreeFindFile')
--      end
--    end
--
--    vim.keymap.set("n", "<leader><space>", ":lua toggle_nvimtree()<CR>", { desc = "Toggle nvim tree focus" })
  end
}
