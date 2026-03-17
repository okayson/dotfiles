-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- [[ Highlight config ]]
local highlight_cfg = vim.api.nvim_create_augroup('HighlightConfig', { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = highlight_cfg,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Filetype config ]]
local filetype_cfg = vim.api.nvim_create_augroup('FileTypeConfig', { clear = true })

-- Don't auto comment new lines
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable auo comment new lines',
  group = filetype_cfg,
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'o' }
  end,
})

local function set_indent(n, et)
  vim.opt_local.shiftwidth = n
  vim.opt_local.softtabstop = n
  vim.opt_local.tabstop = n
  vim.opt_local.expandtab = et
end

-- vim.api.nvim_create_autocmd('FileType', {
--   group = filetype_cfg,
--   pattern = 'sh',
--   callback = function()
--     set_indent(2)
--   end,
-- })

-- vim.api.nvim_create_autocmd('FileType', {
--   group = filetype_cfg,
--   pattern = { 'c', 'cpp' },
--   callback = function()
--     set_indent(4)
--   end,
-- })

-- [[ IME config ]]
local ime_cfg = vim.api.nvim_create_augroup('IMEConfig', { clear = true })

-- IME OFF
local function ime_off()
  -- Windows or WSL
  if vim.fn.has 'win32' == 1 or vim.fn.has 'wsl' == 1 then
    vim.fn.system 'zenhan.exe 0'
  end
end

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Turn off IME when leaving insert mode',
  group = ime_cfg,
  callback = ime_off,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  desc = 'Turn off IME when leaving command line mode',
  group = ime_cfg,
  callback = ime_off,
})

-- vim: ts=2 sts=2 sw=2 et
