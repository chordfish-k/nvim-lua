vim.g.mapleader = " "

local opts = {noremap = true, silent = true}

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<S-L>", ":bnext<CR>")
keymap.set("n", "<S-H>", ":bprevious<CR>")

-- 返回上一个位置
keymap.set("n", "<C-[>", "<C-T>")

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- 终端
keymap.set('n', '<c-t>', ':ToggleTerm<CR>', opts)
keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
keymap.set('t', '<c-t>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

-- 查看大纲
keymap.set("n", "<leader>o", "<cmd>Outline<CR>",{ desc = "Toggle Outline" })

-- LazyGit
keymap.set("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- dap调试器
vim.keymap.set('n', '<F5>', function() require 'telescope'.extensions.dap.configurations {} end)
vim.keymap.set('n', '<F9>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
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

-- 快捷命令
keymap.set("n", "<leader>w", ":w<CR>") -- Space + s + Space
keymap.set("n", "<leader>q", ":q<CR>")
