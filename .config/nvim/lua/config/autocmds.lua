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

-- Move to last position on new file opened
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Not sure?
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Also not really sure
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})
