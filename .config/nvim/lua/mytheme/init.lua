local M = {};

local colors = {
  bg = "#020202",
  fg = "#ffffff",
  red = "#9a290e",
  green = "#23a03c",
  yellow = "#caa311",
  blue = "#1f788b",
  magenta = "#f5c2e7",
  cyan = "#94e2d5",
  gray = "#363b3a"
}

function M.colorscheme()
  vim.cmd('highlight clear')
  vim.cmd('syntax reset')
  vim.o.background = 'dark'
  vim.g.colors_name = 'mytheme'

  local set = vim.api.nvim_set_hl

  set(0, "Normal", { bg = colors.bg, fg = colors.fg })
end

return M
