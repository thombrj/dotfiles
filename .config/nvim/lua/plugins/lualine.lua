return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1
          },
        },
          lualine_x = {
            {
              'lsp_status',
              icon = '', -- f013
              symbols = {
                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                done = '✓',
                separator = ' ',
              },
              ignore_lsp = {},
            }
          },
      }
    }
  },
}
