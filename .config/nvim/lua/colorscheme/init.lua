-- Theme used at startup
local CURRENT = 'catppuccin'
-- local CURRENT = 'tokyonight'

-- List of themes
local themes = {
  catppuccin = {
    repo = 'catppuccin/nvim',
    name = 'catppuccin',
  },
  tokyonight = {
    repo = 'folke/tokyonight.nvim',
    name = 'tokyonight',
  },
  sonokai = {
    repo = 'sainnhe/sonokai',
    name = 'sonokai',
  },
  kanagawa = {
    repo = 'rebelot/kanagawa.nvim',
    name = 'kanagawa',
  },
}

local plugins = {}

for key, theme in pairs(themes) do
  table.insert(plugins, {
    theme.repo,
    name = theme.name,

    --Only the startup theme has lazy=false
    lazy = key ~= CURRENT,

    -- Only the startup theme is given the highest priority.
    priority = (key == CURRENT) and 1000 or nil,

    config = function()
      -- Execute setup for each theme
      require('colorscheme.' .. key)()

      -- If it is the startup theme, apply it
      if key == CURRENT then
        vim.cmd.colorscheme(theme.name)
      end
    end,
  })
end

return plugins
