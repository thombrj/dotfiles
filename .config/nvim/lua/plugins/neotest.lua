return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "issafalcon/neotest-dotnet",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({
          dap = {
            adapter_name = "coreclr"
          },
          discovery_root = "solution"
        })
      }
    })
    vim.keymap.set("n", "<leader>et", "<cmd>Neotest summary<CR>", { desc = "Open test explorer" })
    vim.keymap.set("n", "<leader>tr", "<cmd>Neotest run<CR>", { desc = "Run nearest test" })
  end
}
