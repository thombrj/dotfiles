return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    enabled = false,
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', function() 
            local curr_row = vim.api.nvim_win_get_cursor(0)[1]
            vim.lsp.buf.code_action { ["range"] = { ["start"] = { curr_row, 0 }, ["end"] = { curr_row, 100 }}}
          end, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          client.server_capabilities.semanticTokensProvider = nil

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          local inlayHintSupported = client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
          if inlayHintSupported then
            vim.lsp.buf.inlay_hint(bufnr, true)
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
              end,
            })
          end
        end,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        terraformls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
              }
            },
          },
        },
        yamlls = {},
      }

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      require "lspconfig".omnisharp.setup{
        cmd = { "omnisharp" },
        capabilities = capabilities,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = nil,
          }
        }
        --cmd = { "dotnet", "/home/bryce/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll" }
      }
    end
  }
}

-- return {
--   'neovim/nvim-lspconfig',
--   dependencies = {
--     {
--       'mason-org/mason.nvim',
--       opts = {
--         registries = {
--           "github:mason-org/mason-registry",
--           "github:Crashdummyy/mason-registry"
--         }
--       }
--     },
--     'mason-org/mason-lspconfig.nvim',
--     'WhoIsSethDaniel/mason-tool-installer.nvim',
--
--     { 'j-hui/fidget.nvim', opts = {} },
--
--     'hrsh7th/cmp-nvim-lsp',
--   },
--   config = function()
--     vim.api.nvim_create_autocmd('LspAttach', {
--       group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
--       callback = function(event)
--         local map = function(keys, func, desc, mode)
--           mode = mode or 'n'
--           vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
--         end
--         map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--         map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--         map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--         map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--         map('<leader>ds', requi re('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--         map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--         map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--         map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
--         map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
--           local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
--           vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--             buffer = event.buf,
--             group = highlight_augroup,
--             callback = vim.lsp.buf.document_highlight,
--           })
--
--           vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--             buffer = event.buf,
--             group = highlight_augroup,
--             callback = vim.lsp.buf.clear_references,
--           })
--
--           vim.api.nvim_create_autocmd('LspDetach', {
--             group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
--             callback = function(event2)
--               vim.lsp.buf.clear_references()
--               vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
--             end,
--           })
--         end
--
--         if client  and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
--           map('<leader>th', function()
--             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
--           end, '[T]oggle Inlay [H]ints')
--         end
--
--         if client.supports_method('textDocument/formatting') then
--           vim.api.nvim_create_autocmd('BufWritePre', {
--             buffer = event.buf,
--             callback = function()
--               vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
--             end,
--           })
--         end
--       end,
--     })
--
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
--
--
--    --   end
-- }

