return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup {
        --commentStyle = { italic = false },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
