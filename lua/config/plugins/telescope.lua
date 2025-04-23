local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = '' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

return {
    {
        'vim-telescope/telescope.nvim', 
        tag = '0.1.8',
        dependencies = { 
            'nvim-lua/plenary.nvim', 
            {'nvim-telescope/telescope-fzf-native.nvim'}
        },
       config = function()
           require('telescope').setup {
               pickers = {
                   find_files = {
                       theme = 'ivy'
                   }
               }
           }
            vim.keymap.set('n', '<leader>en', function() 
                builtin.find_files {
                     cwd = vim.fn.stdpath("config")
                } 
            end)

            vim.keymap.set('n', '<leader>fh', builtin.help_tags)

            vim.keymap.set('n', '<leader>pf', function()
                builtin.find_files() 
            end)
        end
    }
}
