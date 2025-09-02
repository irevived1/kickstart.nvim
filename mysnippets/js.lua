local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('javascriptreact', {
  -- set attributes to component
  s('jk', {
    i(1, 'attr'),
    t '={',
    i(2, 'value'),
    t '}',
  }),
})
