return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- Icons
  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },

  -- Active theme: tender (matches nvim setup)
  {
    'jacoborus/tender.vim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tender'
    end,
  },

  -- Other themes (available but not active)
  { 'catppuccin/nvim', name = 'catppuccin', priority = 999 },
  { 'navarasu/onedark.nvim', priority = 999 },
  { 'marko-cerovac/material.nvim', priority = 999 },
  { 'scottmckendry/cyberdream.nvim', lazy = true },

  { 'NvChad/nvim-colorizer.lua', opts = {
    user_default_options = {
      css = true,
    },
  } },
}
