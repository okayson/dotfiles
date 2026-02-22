-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- To paste the default configuration in a buffer, call the following in Neovim:
-- `lua require("neo-tree").paste_default_config()`
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
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['/'] = 'noop', -- disable fuzzy finder
          ['t'] = 'noop', -- disable open in new tab on default
          ['to'] = 'open_tabnew', -- Configured similarly to the tabpage keymap in keymap.lua.
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<C-H>'] = 'navigate_up',
          --['xx'] = 'expand_all_nodes:',
          --['yy'] = 'close_all_subnodes:',
        },
      },
    },
  },
}

--See `neo-tree-filtered-items`
