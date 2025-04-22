--Adding on ctrl + / new line 
local function newLineFromNormalMode()
	local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
	vim.api.nvim_feedkeys('O', 'n', true)
	vim.api.nvim_feedkeys(keys, 'm', false)
end

vim.keymap.set("n", "<C-m>", function() newLineFromNormalMode() end)

--folding
vim.keymap.set("n", "<C-i>","<Cmd>set foldmethod=indent<CR>")


--Save file on [[
vim.keymap.set({"n", "x", "i", "s"}, "<C-]>", "<cmd>w<cr><esc>")


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-d>zz")
vim.keymap.set("n", "<C-i>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set(
"n", 
"<leader>s", 
[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

vim.api.nvim_set_keymap("n", "<leader>,", "<C-w>h", { })
vim.api.nvim_set_keymap("n", "<leader>.", "<C-w>l", { })
vim.keymap.set("n", "<leader>/", ":noh<cr>", { })
