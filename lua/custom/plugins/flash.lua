return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    require('flash').setup {
      modes = {
        char = {
          enabled = false,
          -- keys = { 'f', 'F', 't', 'T', ';', ',' },
        },
      },
    }
    vim.keymap.set({'n', 'v', 'o'}, 'f', '<cmd>lua require("flash").jump()<CR>', { noremap = true, desc = 'flash search' })
    vim.keymap.set(
      {'n', 'v', 'o'},
      'F',
      '<cmd>lua require("flash").jump({search = { forward = false, wrap = false, multi_window = false }})<CR>',
      { noremap = true, desc = 'flash search backwards' }
    )
  end,
}
