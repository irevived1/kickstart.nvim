return {
  -- Seamless navigation between vim splits and tmux panes with C-h/j/k/l
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
    lazy = false,
    opts = {
      default = {
        directory = { glyph = '󰉋', hl = 'IconFolder' },
      },
      extension = {
        md  = { glyph = '󰍔', hl = 'IconMarkdown' },
        mdx = { glyph = '󰍔', hl = 'IconMarkdown' },
        ts  = { glyph = '󰛦', hl = 'IconTs' },
        tsx = { glyph = '󰛦', hl = 'IconTsx' },
        jsx = { glyph = '󰛦', hl = 'IconTsx' },
        js  = { glyph = '󰌞', hl = 'IconJs' },
        json = { glyph = '󰘦', hl = 'IconJson' },
        lua = { glyph = '󰢱', hl = 'IconLua' },
      },
      filetype = {
        typescript     = { glyph = '󰛦', hl = 'IconTs' },
        typescriptreact = { glyph = '󰛦', hl = 'IconTsx' },
        javascriptreact = { glyph = '󰛦', hl = 'IconTsx' },
        markdown       = { glyph = '󰍔', hl = 'IconMarkdown' },
        javascript     = { glyph = '󰌞', hl = 'IconJs' },
        json           = { glyph = '󰘦', hl = 'IconJson' },
        lua            = { glyph = '󰢱', hl = 'IconLua' },
      },
    },
    config = function(_, opts)
      -- Define icon highlight groups before setup so they exist when mini.icons first runs.
      -- These are re-applied in tender's config because colorscheme load resets all highlights.
      vim.api.nvim_set_hl(0, 'IconFolder',   { fg = '#d4935a' })
      vim.api.nvim_set_hl(0, 'IconTs',       { fg = '#7eacc0' })
      vim.api.nvim_set_hl(0, 'IconTsx',      { fg = '#4d9ab0' })
      vim.api.nvim_set_hl(0, 'IconMarkdown', { fg = '#a8a8a8' })
      vim.api.nvim_set_hl(0, 'IconJs',       { fg = '#d4935a' })
      vim.api.nvim_set_hl(0, 'IconJson',     { fg = '#8ab89c' })
      vim.api.nvim_set_hl(0, 'IconLua',      { fg = '#7eacc0' })
      require('mini.icons').setup(opts)
    end,
    init = function()
      -- Make mini.icons respond to require('nvim-web-devicons') so plugins that
      -- depend on devicons (e.g. lualine, bufferline) get icons without the real package.
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
      -- Re-apply icon colors after colorscheme load
      vim.api.nvim_set_hl(0, 'IconFolder',   { fg = '#d4935a' })
      vim.api.nvim_set_hl(0, 'IconTs',       { fg = '#7eacc0' })
      vim.api.nvim_set_hl(0, 'IconTsx',      { fg = '#4d9ab0' })
      vim.api.nvim_set_hl(0, 'IconMarkdown', { fg = '#a8a8a8' })
      vim.api.nvim_set_hl(0, 'IconJs',       { fg = '#d4935a' })
      vim.api.nvim_set_hl(0, 'IconJson',     { fg = '#8ab89c' })
      vim.api.nvim_set_hl(0, 'IconLua',      { fg = '#7eacc0' })
      -- Light gray border for all LSP/diagnostic floating windows
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#666666', bg = '#282828' })
      -- lspsaga uses SagaBorder instead of FloatBorder for its hover and peek windows
      vim.api.nvim_set_hl(0, 'SagaBorder',  { fg = '#666666', bg = '#282828' })
      -- Force Snacks windows to use the same bg as the editor (#282828)
      vim.api.nvim_set_hl(0, 'SnacksNormal',   { fg = '#eeeeee', bg = '#282828' })
      vim.api.nvim_set_hl(0, 'SnacksNormalNC', { fg = '#eeeeee', bg = '#282828' })
      vim.api.nvim_set_hl(0, 'NormalFloat',    { fg = '#eeeeee', bg = '#282828' })
      -- Explorer cursor line: subtle teal tint, no fg override (preserves icon colors)
      vim.api.nvim_set_hl(0, 'SnacksPickerCursorLine',     { bg = '#242e32' })
      vim.api.nvim_set_hl(0, 'SnacksPickerListCursorLine', { bg = '#242e32' })
      -- Match NERDTree-style colors from tender
      vim.api.nvim_set_hl(0, 'SnacksPickerDirectory',         { fg = '#b3deef', bg = '#282828' })
      vim.api.nvim_set_hl(0, 'SnacksPickerFile',              { fg = '#eeeeee', bg = '#282828' })
      vim.api.nvim_set_hl(0, 'SnacksPickerTree',              { fg = '#444444', bg = '#282828' })
      vim.api.nvim_set_hl(0, 'SnacksPickerGitStatusAdded',    { fg = '#c9d05c' })
      vim.api.nvim_set_hl(0, 'SnacksPickerGitStatusModified', { fg = '#ffc24b' })
      vim.api.nvim_set_hl(0, 'SnacksPickerGitStatusDeleted',  { fg = '#f43753' })
    end,
  },

  -- Other themes installed but not active (switch via \uC colorscheme picker)
  { 'catppuccin/nvim', name = 'catppuccin', priority = 999 },
  { 'navarasu/onedark.nvim', priority = 999 },
  { 'marko-cerovac/material.nvim', priority = 999 },
  { 'scottmckendry/cyberdream.nvim', lazy = true },

  -- Inline color previews in CSS and style files
  { 'NvChad/nvim-colorizer.lua', opts = {
    user_default_options = {
      css = true,
    },
  } },
}
