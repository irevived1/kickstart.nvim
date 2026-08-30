local ls = require 'luasnip'
local s = ls.snippet   -- defines a snippet trigger
local t = ls.text_node -- static text
local i = ls.insert_node -- tab stop with placeholder

-- JSX snippets
ls.add_snippets('javascriptreact', {
  -- jk → attr={value}  (quickly write a JSX prop with tab stops for name and value)
  s('jk', {
    i(1, 'attr'),
    t '={',
    i(2, 'value'),
    t '}',
  }),
})
