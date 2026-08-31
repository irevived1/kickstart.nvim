return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('lspsaga').setup {
      lightbulb  = { enabled = false },
      breadcrumbs = { enabled = false },
      -- Disable code_action virtual text / inline preview
      code_action = {
        show_server_name = false,
        extend_gitsigns = false,
      },
    }

    -- Only use lspsaga for peek definition — everything else stays stock
    vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition' })
  end,
}
