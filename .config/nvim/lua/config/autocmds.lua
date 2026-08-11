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

-- resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd ="
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end
})
--
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
--   command = "if mode() != 'c' | checktime | endif",
--   pattern = "*"
-- })
--
-- On lsp attach, configure stuff
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('K', vim.lsp.buf.hover, 'LSP Hover')
    map('gi', vim.lsp.buf.implementation, 'LSP Go to Implementation')
    map('<C-k>', vim.lsp.buf.signature_help, 'LSP Signature help')
    map('gd', vim.lsp.buf.definition, 'LSP Definition')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [Actions]')
    map('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil

    -- Highlighting current cursor references
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
    then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end

    -- Format on save
    -- if client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     buffer = event.buf,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
    --     end,
    --   })
    -- end
  end,
})
