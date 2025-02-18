--Adding on ctrl + / new line 
local function newLineFromNormalMode()
	local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
	vim.api.nvim_feedkeys('O', 'n', true)
	vim.api.nvim_feedkeys(keys, 'm', false)
end

vim.keymap.set("n", "<C-m>", function() newLineFromNormalMode() end)

--folding
vim.keymap.set("n", "<C-i>","<Cmd>set foldmethod=indent<CR>")


--auto complete brackets and quoteo
vim.keymap.set('i', '"', '""<left>', { noremap = true })
vim.keymap.set('i', '""', '""', { noremap = true })

vim.keymap.set('i', "'", "''<left>", { noremap = true })
vim.keymap.set('i', "''", "''", { noremap = true })

vim.keymap.set('i', '(', '()<left>', { noremap = true })
vim.keymap.set('i', '()', '()', { noremap = true })

vim.keymap.set('i', '[', '[]<left>', { noremap = true })
vim.keymap.set('i', '[]', '[]', { noremap = true })

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

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

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

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.api.nvim_set_keymap("n", "<leader>,", "<C-w>h", { })
vim.api.nvim_set_keymap("n", "<leader>.", "<C-w>l", { })






















