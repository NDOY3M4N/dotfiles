require('luasnip.session.snippet_collection').clear_snippets 'php'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('sql', {
  s(
    'fk',
    fmt(
      [[
FOREIGN KEY ({}) REFERENCES {} ({})
  ON UPDATE {} ON DELETE {}{}
]],
      {
        i(1),
        i(2),
        rep(1),
        i(3, 'NO ACTION'),
        rep(3),
        i(0, ','),
      }
    )
  ),
})
