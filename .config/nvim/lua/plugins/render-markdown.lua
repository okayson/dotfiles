return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  ft = { 'markdown' },
  config = function()
    require('render-markdown').setup {
      file_types = { 'markdown' },
      heading = {
        width = 'block',
        left_pad = 0,
        right_pad = 2,
        icons = {},
      },
      checkbox = { checked = { scope_highlight = '@markup.strikethrough' } },
    }
    vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', { desc = '[T]oggle [M]arkdown' })
  end,
}
