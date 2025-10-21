local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Set working directory to current dir for nvim if path is not provided on start
local function change_dir_from_argv()
  local argv = vim.fn.argv()
  if #argv > 0 then
    local path = argv[1]
    local is_dir = vim.fn.isdirectory(path) == 1

    if is_dir then
      vim.cmd('cd ' .. path)
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = change_dir_from_argv
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = 'Highlight when yanking (copying) text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})
