local function go_on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      lspconfig.lua_ls.setup { capabilities = capabilities }

      lspconfig.gopls.setup({
        on_attach = go_on_attach,
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
        root_dir = util.root_pattern("go.work", "go.mod", ".git")
      })

      vim.api.nvim_create_autocmd('LspAttach', {

        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if not client.supports_method('textDocument/formatting') then
            return
          end

          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function(args)
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end,
      })
    end,
  }
}
