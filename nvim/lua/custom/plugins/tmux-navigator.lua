return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  keys = {
    { 'C-h', '<cmd> TmuxNavigateLeft<cr>', desc = 'Navigate left' },
    { 'C-l', '<cmd> TmuxNavigateRight<cr>', desc = 'Navigate right' },
    { 'C-j', '<cmd> TmuxNavigateDown<cr>', desc = 'Navigate down' },
    { 'C-k', '<cmd> TmuxNavigateUp<cr>', desc = 'Navigate up' },
  },
}
