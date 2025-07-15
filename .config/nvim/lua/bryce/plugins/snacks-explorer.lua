return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
    }
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = vim.loop.cwd() })
      end,
      desc = "Explorer Snacks root dir", remap = true
    }
  }

}
