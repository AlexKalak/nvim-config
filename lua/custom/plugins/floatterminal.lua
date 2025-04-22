vim.keymap.set("t", "<C-[>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-]>", "<C-\\><C-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	}
}

local function create_floating_window(opts)
  opts = opts or {}
  local width_ratio = opts.width_ratio or 0.8
  local height_ratio = opts.height_ratio or 0.5

  local width = math.floor(vim.o.columns * width_ratio)
  local height = math.floor(vim.o.lines * height_ratio)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(state.floating.buf) then
	  buf = state.floating.buf
  else 
	   buf = vim.api.nvim_create_buf(false, true)
  end

  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win= win }
end

--state.floating = create_floating_window(); 

-- Create user command with optional arguments

local toggle_terminal = function(params)
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window()
		print(state.floating)
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("FloatingTerminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<C-\\><C-\\>", toggle_terminal) 

