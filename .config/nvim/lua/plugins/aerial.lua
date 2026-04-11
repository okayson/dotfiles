return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'AerialToggle',
    'AerialOpen',
    'AerialOpenAll',
    'AerialNavToggle',
    'AerialNavOpen',
  },
  keys = {
    { '<leader>o', '<cmd>AerialOpen<CR>', desc = '[O]utline by Aerial' },
  },
}
