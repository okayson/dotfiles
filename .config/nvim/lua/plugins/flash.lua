return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        jump_labels = true,
        multi_line = false,
      },
    },
  },
  keys = {
    {
      'sa',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump {
          label = { min_pattern_length = 2, rainbow = { enabled = false, shade = 5 } },
        }
      end,
      desc = 'Flash',
    },
    {
      -- 'st',
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote {
          label = { min_pattern_length = 2 },
        }
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search {
          label = { min_pattern_length = 2 },
        }
      end,
      desc = 'Treesitter Search',
    },
    {
      'sj',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump {
          search = { multi_window = false, forward = true, wrap = false, mode = 'search' },
          label = { after = { 0, 0 } },
          pattern = '^',
        }
      end,
      desc = 'Flash After Line',
    },
    {
      'sk',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump {
          search = { multi_window = false, forward = false, wrap = false, mode = 'search' },
          label = { after = { 0, 0 } },
          pattern = '^',
        }
      end,
      desc = 'Flash Before Line',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
