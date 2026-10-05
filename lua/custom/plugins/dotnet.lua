-- C# / .NET: treesitter parsers, Roslyn LSP and a netcoredbg debug adapter.
--
-- Mason packages (roslyn, csharpier, netcoredbg) are listed in
-- lua/custom/lsp_servers.lua `tools`; `roslyn` comes from the
-- Crashdummyy registry added to mason.setup in init.lua SECTION 6.
-- Formatting (csharpier on save) lives in lua/custom/plugins/format.lua.

-- [[ Treesitter ]]
-- xml for .csproj / .props, json for appsettings.json / launchSettings.json
require('nvim-treesitter').install { 'c_sharp', 'xml', 'json' }

-- [[ LSP: Roslyn ]]
-- roslyn.nvim starts the server itself (and picks the .sln / .csproj), so it
-- is intentionally NOT in lsp_servers.lua `servers`. `:Roslyn target` switches
-- solution when several are found.
vim.pack.add { 'https://github.com/seblyng/roslyn.nvim' }

vim.lsp.config('roslyn', {
  settings = {
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
    ['csharp|completion'] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
    },
    ['csharp|navigation'] = {
      -- go-to-definition into BCL types opens decompiled sources
      dotnet_navigate_to_decompiled_sources = true,
    },
    ['csharp|symbol_search'] = {
      dotnet_search_reference_assemblies = true,
    },
  },
})

require('roslyn').setup {}

-- [[ Debugging: netcoredbg ]]
-- nvim-dap / dap-ui and the F-key keymaps come from kickstart.plugins.debug.
local dap = require 'dap'

local netcoredbg = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', 'netcoredbg')
if vim.fn.executable(netcoredbg) == 0 then netcoredbg = 'netcoredbg' end

dap.adapters.coreclr = {
  type = 'executable',
  command = netcoredbg,
  args = { '--interpreter=vscode' },
}

--- Directory of the nearest .csproj above the current buffer (or cwd).
local function project_root()
  return vim.fs.root(0, function(name) return name:match '%.csproj$' ~= nil end) or vim.fn.getcwd()
end

--- Build the project, then return the path of its freshly built Debug dll.
local function build_and_find_dll()
  local root = project_root()
  local csproj = vim.fn.glob(vim.fs.joinpath(root, '*.csproj'), false, true)[1]

  vim.notify('dotnet build ' .. vim.fn.fnamemodify(root, ':~'), vim.log.levels.INFO)
  local result = vim.system({ 'dotnet', 'build', '-c', 'Debug' }, { cwd = root, text = true }):wait()
  if result.code ~= 0 then
    vim.notify('dotnet build failed:\n' .. (result.stdout or '') .. (result.stderr or ''), vim.log.levels.ERROR)
    return dap.ABORT
  end

  if csproj then
    local name = vim.fn.fnamemodify(csproj, ':t:r')
    local dlls = vim.fn.glob(vim.fs.joinpath(root, 'bin', 'Debug', '*', name .. '.dll'), false, true)
    if #dlls == 1 then return dlls[1] end
  end
  return vim.fn.input('Path to dll: ', vim.fs.joinpath(root, 'bin', 'Debug', ''), 'file')
end

dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'Build & launch project',
    request = 'launch',
    program = build_and_find_dll,
    -- run from the project dir so appsettings*.json are picked up
    cwd = project_root,
    env = { ASPNETCORE_ENVIRONMENT = 'Development' },
    -- Console.ReadLine() needs a real terminal
    console = 'integratedTerminal',
  },
  {
    type = 'coreclr',
    name = 'Attach to process',
    request = 'attach',
    processId = function() return require('dap.utils').pick_process { filter = 'dotnet' } end,
  },
}

-- [[ Workflow ]]
-- `:DotnetWatch` opens `dotnet watch run` for the current project in a split
-- (the equivalent of `nest start --watch`).
vim.api.nvim_create_user_command('DotnetWatch', function()
  local root = project_root()
  vim.cmd 'botright vnew'
  vim.fn.jobstart({ 'dotnet', 'watch', 'run' }, { cwd = root, term = true })
  vim.cmd 'wincmd p'
end, { desc = 'dotnet watch run in a terminal split' })
