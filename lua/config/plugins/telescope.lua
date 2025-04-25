return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          }
        },
        defaults = {
        }
      }
      vim.keymap.set('n', '<leader>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)

      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)

      vim.keymap.set('n', '<leader>pf', function()
        require('telescope.builtin').find_files()
      end)
    end
  }
}
