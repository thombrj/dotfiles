vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd('tab split' .. require('vim.lsp.log').get_filename())
end, { desc = 'Open the LSP Log' })

vim.api.nvim_create_user_command('Q', 'q', {})
