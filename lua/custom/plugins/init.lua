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

  -- Themes
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
      }
      require('onedark').load()
    end,
  },
  { 'marko-cerovac/material.nvim', priority = 1000 },
  { 'NvChad/nvim-colorizer.lua', opts = {
    user_default_options = {
      css = true,
    },
  } },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
  },
}
