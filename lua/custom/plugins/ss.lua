return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup()
    vim.keymap.set('n', '<leader>sr', '<cmd>GrugFar<CR>', { desc = '[S]earch and [R]eplace' })
  end,
}
