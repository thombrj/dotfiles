return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('fzf-lua').setup({
      files = {
        follow = true
      }
    })
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "find files with fzf" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "find files with fzf" })
    vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "find files with fzf" })
    vim.keymap.set("n", "<leader><tab>", "<cmd>FzfLua buffers<CR>", { desc = "find files with fzf" })
  end
}
