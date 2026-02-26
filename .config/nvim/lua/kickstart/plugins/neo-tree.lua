-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- To paste the default configuration in a buffer, call the following on command.
--  `lua require("neo-tree").paste_default_config()`
--
-- Filter configuration is documented in `:help neo-tree-filtered-items`.

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<Leader>ff', '<cmd>Neotree toggle current reveal_force_cwd<cr>', desc = 'NeoTree show current' },
    { '<Leader>fe', '<cmd>Neotree toggle left reveal<cr>', desc = 'NeoTree show left' },
    { '<Leader>fg', '<cmd>Neotree toggle float git_status<cr>', desc = 'NeoTree show git' },

    { '<Leader>fq', '<cmd>Neotree close<cr>', desc = 'NeoTree close' },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false, -- Keep cwd. See `neo-tree-cwd`.
      cwd_target = {
        sidebar = 'none',
        current = 'none',
      },
      window = {
        mappings = {
          ['/'] = 'noop', -- disable fuzzy finder
          ['t'] = 'noop', -- disable open in new tab on default
          ['to'] = 'open_tabnew', -- Configured for tabpage-keymap in keymap.lua
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<C-H>'] = 'navigate_up',
          ['z'] = 'noop', -- disable close_all_nodes on default
          ['zz'] = 'close_all_nodes',
          ['zo'] = 'expand_all_subnodes',
          ['zc'] = 'close_all_subnodes',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
