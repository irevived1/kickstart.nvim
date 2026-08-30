local ls = require 'luasnip'
local s = ls.snippet    -- defines a snippet trigger
local t = ls.text_node  -- static text
local i = ls.insert_node -- tab stop with placeholder

-- Snippets available in all file types
ls.add_snippets('all', {
  -- ter → cond ? then : else  (ternary expression with three tab stops)
  s('ter', {
    i(1, 'cond'),
    t ' ? ',
    i(2, 'then'),
    t ' : ',
    i(3, 'else'),
  }),
})
