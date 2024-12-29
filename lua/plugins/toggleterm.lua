
  require("toggleterm").setup(
    {
  --   size = 10,
  --   open_mapping = [[<c-\>]],
  --   hide_numbers = true, -- hide the number column in toggleterm buffers
  --   shade_filetypes = {},
  --   shade_terminals = true,
  --   shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  --   start_in_insert = true,
  --   insert_mappings = true, -- whether or not the open mapping applies in insert mode
  --   persist_size = false,
     direction = "float",
  --   close_on_exit = true, -- close the terminal window when the process exits
  --   shell = nil, -- change the default shell
  --   autochdir = true,
  --   -- dir = "~",
  --   float_opts = {
  --     border = "rounded",
  --     winblend = 0,
  --     highlights = {
  --       border = "Normal",
  --       background = "Normal",
  --     },
  --   },
  --   winbar = {
  --     enabled = true,
  --     name_formatter = function(term) --  term: Terminal
  --       return term.count
  --     end,
  --   },
  })
  
  vim.cmd [[
  augroup terminal_setup | au!
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  autocmd TermEnter * startinsert!
  augroup end
  ]]

  vim.api.nvim_create_autocmd({ "TermEnter" }, {
    pattern = {  "*" },
    callback = function()
      vim.cmd "startinsert"
      _G.set_terminal_keymaps()
    end,
  })

  local opts = { noremap = true, silent = true }
  function _G.set_terminal_keymaps()
    --vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-l>", [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd('autocmd! TermOpen term://*toggleterm# lua set_terminal_keymaps()')

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ 
    cmd = "lazygit", 
    dir = "git_dir",
    hidden = true, 
  
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("startinsert!")
    end,
  })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

