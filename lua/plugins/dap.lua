vim.keymap.set('n', '<leader><F5>', function() require 'telescope'.extensions.dap.configurations {} end)
vim.keymap.set('n', '<leader><F9>', function() require('dap').continue() end)
vim.keymap.set('n', '<leader><F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader><F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader><F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


-- 配置调试器
local dap = require("dap")
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'OpenDebugAD7'
}


-- 找到目录内第一个可执行文件
local function is_executable(file_path)
    -- 使用 `test -x` 检查文件是否具有可执行权限
    return os.execute('test -x "' .. file_path .. '"') == 0
end

local function find_first_executable(dir)
    -- 打开目录，获取文件列表
    local handle = io.popen('ls -A "' .. dir .. '"') -- `-A` 忽略隐藏文件 `.` 和 `..`
    if not handle then
        return nil, "Failed to open directory: " .. dir
    end

    for file in handle:lines() do
        local file_path = dir .. "/" .. file
        local attr = io.popen('stat -c "%F" "' .. file_path .. '"'):read("*a"):gsub("%s+", "")
        if attr == "regular file" and is_executable(file_path) then
            handle:close()
            return file_path -- 返回第一个找到的可执行文件
        end
    end

    handle:close()
    return nil -- 如果没有找到可执行文件
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      local pth = vim.fn.getcwd() .. '/build/Debug/'
      return vim.fn.input('Path to executable: ', pth, 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/Debug/', 'file')
    end,
  },
}


-- 然后配置 nvim-dap-ui
-- local dapui = require('dapui')
-- dapui.setup()
--
-- -- 打开调试时自动显示 UI
-- dap.listeners.after['dap.nvim'] = function()
--   dapui.open()
-- end
