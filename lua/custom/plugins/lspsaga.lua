return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('lspsaga').setup {
      -- Disable features we already have covered by other plugins
      lightbulb = { enabled = false },   -- would overlap with LSP diagnostics display
      breadcrumbs = { enabled = false },  -- lualine handles the context line
      outline = { keys = { toggle = '<leader>o' } },
    }

    -- Replace stock LSP keymaps with Lspsaga equivalents
    vim.keymap.set('n', 'K',           '<cmd>Lspsaga hover_doc<CR>',      { desc = 'Hover doc' })
    vim.keymap.set('n', '<leader>ca',  '<cmd>Lspsaga code_action<CR>',    { desc = 'Code Action' })
    vim.keymap.set('n', '<leader>rn',  '<cmd>Lspsaga rename<CR>',         { desc = 'Rename' })
    vim.keymap.set('n', '<leader>pd',  '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition' })
    vim.keymap.set('n', '[d',          '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = 'Prev diagnostic' })
    vim.keymap.set('n', ']d',          '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = 'Next diagnostic' })
  end,
}
