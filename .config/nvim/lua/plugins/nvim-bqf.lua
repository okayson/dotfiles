return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  -- see current configuration, type `:lua =require('bqf.config')`
  opts = {
    func_map = {
      -- Open
      open = '<CR>',
      openc = 'o',
      drop = 'O',
      split = '<C-x>',
      vsplit = '<C-v>',
      tab = '<C-t>', -- change from default
      tabb = '', -- change from default
      tabc = '', -- change from default
      tabdrop = '',
      -- Preview
      ptogglemode = 'zp', -- toglle size
      ptoggleitem = 'p', -- toggle preview of current item
      ptoggleauto = 'P', -- toggle auto preview
      pscrollup = '<C-b>',
      pscrolldown = '<C-f>',
      pscrollorig = 'zo',
      -- Move in list
      prevfile = '<C-p>',
      nextfile = '<C-n>',
      -- Move in history
      prevhist = '<',
      nexthist = '>',
      lastleave = [['"]],
      -- Toggle sign
      stoggleup = '<S-Tab>', -- toggle sign and move up
      stoggledown = '<Tab>', -- toggle sign and move down
      stogglevm = '<Tab>', -- toggle sign in visual mode
      stogglebuf = [['<Tab>]], -- toggle sign in same buffer
      sclear = 'z<Tab>', -- clear all signs
      filter = 'zn', -- filter for signed
      filterr = 'zN', -- filter for NON-signed
      fzffilter = 'zf', -- fzf mode
    },
  },
}
