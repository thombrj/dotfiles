return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
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
  end
}
