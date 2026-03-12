-- This module manages the colorscheme plugins and their configurations.

-- How to add a new theme:
-- 1. Add the theme plugin to the themes table below with its repository and name.
-- 2. Create a new Lua file in the colorscheme/ directory with the same name as the key in the themes table.

-- List of themes
-- The key is colorscheme plugin name. It is used as file name for the theme configuration in colorscheme/ directory.
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
  gruvbox = {
    repo = 'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
  },
  monokai = {
    repo = 'loctvl842/monokai-pro.nvim',
    name = 'monokai-pro',
  },
}

local state_file = vim.fn.stdpath 'state' .. '/colorscheme.txt'

local function save_colorscheme(colorscheme)
  local f = io.open(state_file, 'w')
  if f then
    f:write(colorscheme)
    f:close()
  end
end

local function load_colorscheme()
  local f = io.open(state_file, 'r')
  if not f then
    return nil
  end
  local colorscheme = f:read '*l'
  f:close()
  return colorscheme
end

local function guess_theme(colorscheme)
  if not colorscheme then
    return nil
  end

  for key, theme in pairs(themes) do
    if colorscheme:match('^' .. theme.name) then
      return key
    end
  end
  return nil
end

-- Autocommands for colorscheme changes
local colorscheme_cfg = vim.api.nvim_create_augroup('ColorSchemeConfig', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Save the current colorscheme to state file',
  group = colorscheme_cfg,
  callback = function()
    local colorscheme = vim.g.colors_name
    save_colorscheme(colorscheme)
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Customize highlight groups after colorscheme is applied',
  group = colorscheme_cfg,
  callback = function()
    -- Change CopilotSuggestion to be the same as base_name but with italic
    --
    --
    local base_name = 'Comment'
    local base_hl = vim.api.nvim_get_hl(0, { name = base_name, link = false })

    vim.api.nvim_set_hl(0, base_name, {
      fg = base_hl.fg,
      bg = base_hl.bg,
      italic = false, -- Disable italic
    })

    vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
      fg = base_hl.fg,
      italic = true, -- Enable italic
    })
  end,
})

-- Theme used at startup
local DEFAULT_THEME = 'tokyonight'
local saved_colorscheme = load_colorscheme()
local current_theme = guess_theme(saved_colorscheme) or DEFAULT_THEME

-- Generate plugin specifications for each theme
local plugins = {}

for key, theme in pairs(themes) do
  table.insert(plugins, {
    theme.repo,
    name = theme.name,

    --Only the startup theme has lazy=false
    lazy = key ~= current_theme,

    -- Only the startup theme is given the highest priority.
    priority = (key == current_theme) and 1000 or nil,

    config = function()
      -- Execute setup for each theme
      require('colorscheme.' .. key)()

      -- If it is the startup theme, apply it
      if key == current_theme then
        vim.cmd.colorscheme(saved_colorscheme)
      end
    end,
  })
end

return plugins
