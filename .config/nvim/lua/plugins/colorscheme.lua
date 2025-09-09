return {
  {
    "catppuccin/nvim"
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "olimorris/onedarkpro.nvim",
  },
  {
    "projekt0n/github-nvim-theme"
  },
  {
    "notken12/base46-colors",
    lazy = false
  }
}
