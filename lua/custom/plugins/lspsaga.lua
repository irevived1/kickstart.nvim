return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('lspsaga').setup {
      lightbulb   = { enabled = false },
      breadcrumbs = { enabled = false },
      code_action = { show_server_name = false, extend_gitsigns = false },
      ui = {
        border = 'rounded',
        -- Use the same FloatBorder color we set for all other floats
      },
    }

    -- Only use lspsaga for peek definition — everything else stays stock
    vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition' })
  end,
}
