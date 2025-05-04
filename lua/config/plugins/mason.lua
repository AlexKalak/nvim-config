return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust_analyzer",
        "eslint-lsp",
        "ts_ls",
      }
    },
    configure = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed = { 'lua_ls', 'rust_analyzer', 'ts_ls', "eslint-lsp" },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        },
      })
    end
  }
}
