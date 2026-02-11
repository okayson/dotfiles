return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
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
    })
  end,
}
