return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  opts = { },
  enabled = false,
  config = function()
    require("roslyn").setup({
      config = {
        cmd = {
          "dotnet",
          "/home/bryce/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        }
      }
    })
  end
}
