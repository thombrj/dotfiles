return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('fzf-lua').setup({
      keymap     = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          true,
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept",
        },
      },
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
