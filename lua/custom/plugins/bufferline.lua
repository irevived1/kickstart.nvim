return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    local arrow = vim.fn.nr2char(0xE0B0)
    require('bufferline').setup {
      options = {
        separator_style = { arrow, arrow },
        show_buffer_close_icons = false,
        show_close_icon = false,
        buffer_close_icon = '',
        close_icon = '',
        modified_icon = '*',
        indicator = { style = 'none' },
        diagnostics = false,
        always_show_bufferline = true,
        show_buffer_icons = true,
        color_icons = false,
        get_element_icon = function(elem)
          local icon, hl, is_default = require('mini.icons').get('extension', elem.extension or '')
          if not is_default then return icon, hl end
          icon, hl = require('mini.icons').get('filetype', elem.filetype or '')
          return icon, hl
        end,
        offsets = {
          {
            filetype = 'snacks_picker_list',
            text = 'Explorer',
            highlight = 'Directory',
            text_align = 'center',
          },
        },
      },
      highlights = {
        fill = { bg = '#282828' },
        background = { fg = '#777777', bg = '#282828' },
        buffer_selected = { fg = '#d8eef4', bg = '#245f70', bold = true, italic = false },
        buffer_visible = { fg = '#888888', bg = '#282828' },
        separator = { fg = '#282828', bg = '#282828' },
        separator_selected = { fg = '#245f70', bg = '#282828' },
        separator_visible = { fg = '#282828', bg = '#282828' },
        modified = { fg = '#d4935a', bg = '#282828' },
        modified_selected = { fg = '#d8eef4', bg = '#245f70' },
        modified_visible = { fg = '#d4935a', bg = '#282828' },
        duplicate = { fg = '#555555', bg = '#282828', italic = true },
        duplicate_selected = { fg = '#d8eef4', bg = '#245f70', italic = true },
        duplicate_visible = { fg = '#666666', bg = '#282828', italic = true },
      },
    }
  end,
}
