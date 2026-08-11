return {
  {
    "catppuccin/nvim"
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },
  {
    "olimorris/onedarkpro.nvim",
  },
  {
    "rose-pine/neovim",
  },
  {
    "vague2k/vague.nvim"
  },
  {
    "folke/tokyonight.nvim"
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup()
      vim.cmd.colorscheme("monokai-pro")
    end,
  }
}
