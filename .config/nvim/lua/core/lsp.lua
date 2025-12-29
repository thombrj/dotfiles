vim.lsp.config("lua_ls", {})
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("jsonls")
vim.lsp.enable("powershell_es")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("gh_actions_ls")

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true
  },
  signs = true,
})
