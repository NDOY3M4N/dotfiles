require('luasnip.session.snippet_collection').clear_snippets 'go'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('go', {
  s(
    'fm',
    fmt(
      [[
func (<>) <>(<>) <> {
  <>
}
]],
      { i(1), i(2), i(3), i(4), i(0) },
      { delimiters = '<>' }
    )
  ),
  s(
    'ff',
    fmt(
      [[
func <>(<>) <> {
  <>
}
]],
      { i(1), i(2), i(3), i(0) },
      { delimiters = '<>' }
    )
  ),
  s(
    'ft',
    fmt(
      [[
import "testing"

func Test<>(t *testing.T) {
  <>
}
]],
      { i(1), i(0) },
      { delimiters = '<>' }
    )
  ),
})
