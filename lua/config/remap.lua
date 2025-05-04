--Adding on ctrl + / new line

local function newLineFromNormalMode(where)
  local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
  if where == 'down' then
    vim.api.nvim_feedkeys('O', 'n', true)
  else
    vim.api.nvim_feedkeys('o', 'n', true)
  end
  vim.api.nvim_feedkeys(keys, 'm', false)
end
vim.keymap.set("n", "<C-m>", function() newLineFromNormalMode('down') end)
vim.keymap.set("n", "<C-n>", function() newLineFromNormalMode('up') end)

--Save file on [[
--vim.keymap.set({ "n", "x", "i", "s" }, "<C-]>", "<cmd>w<cr><esc>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-d>zz")
vim.keymap.set("n", "<C-i>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

function FindStringInLine()
  -- Prompt user for input
  local str = vim.fn.input("Find string: ")
  if str == "" then return end
  str = string.lower(str)

  -- Search for the string only in the current line
  local line = vim.api.nvim_get_current_line()
  line = string.lower(line);
  local col = vim.fn.col('.')
  local from = col

  -- Find the position of the string after the cursor
  local start_pos = string.find(string.sub(line, from), str, 1, true)
  if start_pos then
    -- Move cursor to the start of the found string
    vim.fn.cursor(vim.fn.line('.'), from + start_pos - 1)
  else
    print("String not found on this line")
  end
end

vim.keymap.set('n', '<C-f>', FindStringInLine, { noremap = true, silent = true })

function SearchWordUnderCursor()
  -- Get the word under the cursor
  local word = vim.fn.expand("<cword>")
  if word == "" then
    print("No word under cursor.")
    return
  end

  -- Escape special characters for Vim regex
  local escaped_word = vim.fn.escape(word, '\\/.*$^~[]')
  print("esc word ", escaped_word)

  -- Set the search pattern and highlight matches
  vim.fn.setreg('/', '\\V\\<' .. escaped_word .. '\\>') -- exact word match
  vim.cmd('normal! n')                                  -- jump to next matchd
end

vim.keymap.set('n', '<leader>fw', SearchWordUnderCursor, { noremap = true, silent = true })


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")


vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.api.nvim_set_keymap("n", "<leader>wl", "<C-w>h", {})
vim.api.nvim_set_keymap("n", "<leader>wh", "<C-w>l", {})
vim.api.nvim_set_keymap("n", "<leader>wk", "<C-w>k", {})
vim.api.nvim_set_keymap("n", "<leader>wj", "<C-w>j", {})

vim.keymap.set("n", "<leader>/", ":noh<cr>", {})
