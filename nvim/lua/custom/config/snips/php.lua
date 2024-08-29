require('luasnip.session.snippet_collection').clear_snippets 'php'

local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('php', {
  -- NOTE: pretty var_dump
  s(
    'vdd',
    fmt(
      [[
echo '<pre>';
var_dump({});
die();
echo '</pre>';{}
]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    'pf',
    fmt(
      [[
<> function <>(<>)
{
    <>
}
]],
      {

        c(1, {
          t 'public',
          t 'private',
        }),
        i(2),
        i(3),
        i(0),
      },
      { delimiters = '<>' }
    )
  ),
})
