return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        --hide_during_completion = false,
        keymap = {
          accept = '<C-l>',
          --accept = '<C-y>',
          dismiss = '<C-d>',
          next = '<C-n>',
          prev = '<C-p>',
        },
      },
      panel = { enabled = false },
    }
    -- vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
    --   -- see: https://stephango.com/flexoki
    --   -- cyan
    --   -- fg = '#3AA99F',
    --   fg = '#2F968D',
    --   -- blue
    --   -- fg = '#4385BE',
    --   -- fg = '#66A0C8',
    --   -- magenta
    --   -- fg = '#F4A4C2',
    --   -- fg = '#CE5D97',
    --   -- yellow
    --   -- fg = '#D0A215',
    --   -- fg = '#AD8301',
    --   italic = true, -- Enable italic
    -- })
  end,
}
