vim.filetype.add {
  extension = { mdx = 'mdx' },
  pattern = {
    ['.*%.component%.html'] = 'htmlangular',
  },
}

vim.treesitter.language.register('markdown', 'mdx')
