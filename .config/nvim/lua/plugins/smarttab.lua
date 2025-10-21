return {
  "boltlessengineer/smart-tab.nvim",
  config = function()
    require('smart-tab').setup {
      skips = { "string_content" },
      mapping = "<tab>",
      exclude_filetypes = {}
    }
  end
}
