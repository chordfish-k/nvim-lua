-- 自动安装packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua，适应本地文件名字
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim' -- 主题
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',  -- 状态栏
  
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }  -- 状态栏图标
  }
  use {
    'nvim-tree/nvim-tree.lua',  -- 文档树
    requires = {
      'nvim-tree/nvim-web-devicons', -- 文档树图标
    }
  }
  use "christoomey/vim-tmux-navigator" -- 用ctl-hjkl来定位窗口
  use "nvim-treesitter/nvim-treesitter" -- 语法高亮
  use "p00f/nvim-ts-rainbow" -- 配合treesitter，不同括号颜色区分
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",  -- 这个相当于mason.nvim和lspconfig的桥梁
    "neovim/nvim-lspconfig"
  }
  -- 自动补全
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip" -- snippets引擎，不装这个自动补全会出问题
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"
  use "hrsh7th/cmp-path" -- 文件路径

  use "numToStr/Comment.nvim" -- gcc和gc注释
  use "windwp/nvim-autopairs" -- 自动补全括号

  use {"akinsho/bufferline.nvim", requires = { 'kyazdani42/nvim-web-devicons', opt = true }} -- buffer分割线
  use "lewis6991/gitsigns.nvim" -- 左则git提示

  use {
    'nvim-telescope/telescope.nvim',  -- 文件检索
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {"akinsho/toggleterm.nvim", tag = '*'}
  -- nvim v0.7.2
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = { 
        "nvim-lua/plenary.nvim",
    },
  })
  
  -- 调试器
  use "ravenxrz/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use 'nvim-neotest/nvim-nio'
  use {"rcarriga/nvim-dap-ui", tag="v3.9.0"}
  use "nvim-telescope/telescope-dap.nvim"

  -- 大纲
  use { "hedyhli/outline.nvim", version = "1.0.0" } 

  -- 自动会话
  -- use "rmagatti/auto-session"

  -- cmake-tools
  use 'Civitasv/cmake-tools.nvim'

  -- dashboard
  -- use {
  --   'nvimdev/dashboard-nvim',
  --   requires = { 'nvim-tree/nvim-web-devicons' },
  -- }
  use {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    requires = { "nvim-tree/nvim-web-devicons" }, -- 可选图标支持
    config = function()
      require('dashboard').setup({
        theme = 'hyper',  -- 可选 'doom' 或 'hyper'
        config = {
          header = {
            '',
[[⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕                         ]],
[[⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕   _   _                 ]],
[[⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕  | \ | |                ]],
[[⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕  |  \| |   ___    ___   ]],
[[⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑  | . ` |  / _ \  / _ \  ]],
[[⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐  | |\  | |  __/ | (_) | ]],
[[⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐  |_| \_|  \___|  \___/  ]],
[[⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔ __      __ _            ]],
[[⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕ \ \    / /(_)           ]],
[[⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕  \ \  / /  _  _ __ ___  ]],
[[⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕   \ \/ /  | || '_ ` _ \ ]],
[[⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕    \  /   | || | | | | |]],
[[⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁     \/    |_||_| |_| |_|]],
[[⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿                         ]],
           '',
          },    
        },
      })
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
