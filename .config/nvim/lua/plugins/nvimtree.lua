return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netwrPlugin = 1

    local map = vim.keymap.set
    map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
    map("n", "<A-n>", "<CMD>NvimTreeToggle<CR>")
    require("nvim-tree").setup()
  end
}
