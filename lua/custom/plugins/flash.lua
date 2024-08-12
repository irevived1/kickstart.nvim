return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    require('flash').setup()
    vim.keymap.set('n', 'f', '<cmd>lua require("flash").jump()<CR>', { noremap = true, desc = 'flash search' })
    vim.keymap.set(
      'n',
      'F',
      '<cmd>lua require("flash").jump({search = { forward = false, wrap = false, multi_window = false }})<CR>',
      { noremap = true, desc = 'flash search backwards' }
    )
  end,
}
