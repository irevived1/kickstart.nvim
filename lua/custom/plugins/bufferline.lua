return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('bufferline').setup {
      options = {
        separator_style = 'thin',
        indicator = { style = 'underline' },
        show_buffer_close_icons = false,
        show_close_icon = false,
        modified_icon = '*',
        diagnostics = false,
        always_show_bufferline = true,
        show_buffer_icons = true,
        color_icons = true,
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
        fill                = { bg = '#282828' },
        background          = { fg = '#666666', bg = '#282828' },
        -- fg drives underline color when terminal lacks guisp support
        buffer_selected     = { fg = '#73cef4', bg = '#282828', bold = true, underline = true },
        buffer_visible      = { fg = '#888888', bg = '#282828' },
        indicator_selected  = { fg = '#73cef4', sp = '#73cef4', underline = true },
        separator           = { fg = '#3a3a3a', bg = '#282828' },
        separator_selected  = { fg = '#3a3a3a', bg = '#282828' },
        separator_visible   = { fg = '#3a3a3a', bg = '#282828' },
        modified            = { fg = '#d4935a', bg = '#282828' },
        modified_selected   = { fg = '#d4935a', bg = '#282828' },
        modified_visible    = { fg = '#d4935a', bg = '#282828' },
        duplicate           = { fg = '#555555', bg = '#282828', italic = true },
        duplicate_selected  = { fg = '#cccccc', bg = '#282828', italic = true },
        duplicate_visible   = { fg = '#666666', bg = '#282828', italic = true },
      },
    }
  end,
}
