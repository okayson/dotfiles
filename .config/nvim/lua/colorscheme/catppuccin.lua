return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup {
        styles = {
          -- comments = {}, -- Disable italic for comments.
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
