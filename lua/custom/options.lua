-- Personal options / UI overrides applied after upstream kickstart setup.
-- OSC 52 clipboard stays in init.lua SECTION 1 (must run before provider pick).

vim.o.relativenumber = true

-- Prefer built-in quiet over the upstream tokyonight install/setup.
vim.o.background = 'dark'
vim.cmd.colorscheme 'catppuccin'

-- Richer cursor location in mini.statusline.
local ok, statusline = pcall(require, 'mini.statusline')
if ok then
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l/%L:%-2v | %p%%' end
end

-- Treesitter folding, set globally so every window gets it (the per-buffer
-- `vim.wo` variant in init.lua SECTION 9 only hits the current window).
-- Buffers without a parser fall back to no folds instead of erroring.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = '' -- keep syntax highlighting on the folded line
-- Open files fully unfolded; `za` / `zc` still work on demand.
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
