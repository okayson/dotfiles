-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- [How to check key mappings]
-- Detault  key map > :h index.txt
-- Assigned key map > :verbose map(or nmap/imap/vmap)

-- [Guide line]
-- for moving.
--   mode    : Normal/Visual/Operator-pending
--   command : noremap
-- for seclecting.
--   mode    : Visual/Operator-pending
--   command : vnoremap/onoremap
-- for inputing.
--   mode    : Insert/Command-line(optional)
--   command : inoremap
-- for executing function.
--   mode    : Normal
--   command : nnoremap

local map = vim.keymap.set

map({ 'n', 'v', 'o' }, 'j', 'gj', { desc = 'Move down by display line' })
map({ 'n', 'v', 'o' }, 'k', 'gk', { desc = 'Move up by display line' })
map({ 'n', 'v', 'o' }, 'gj', 'j', { desc = 'Move down by physical line' })
map({ 'n', 'v', 'o' }, 'gk', 'k', { desc = 'Move up by physical line' })

map({ 'n', 'v', 'o' }, 'sh', '^', { desc = 'Go to first non-blank of line' })
map({ 'n', 'v', 'o' }, 'sH', '0', { desc = 'Go to first of line' })
map({ 'n', 'v', 'o' }, 'sl', '$', { desc = 'Go to end of line' })
map({ 'n', 'v', 'o' }, 'sp', '%', { desc = 'Go to matching bracket' })

map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

map('n', '*', '*N', { desc = 'Search next word and stay' })
map('n', '#', '#N', { desc = 'Search previous word and stay' })

-- common post action: update search register & clear highlight
local post = '<cmd>let @/ = @"<CR><cmd>nohlsearch<CR>'
map('n', 'cy', 'cw<C-r>0<Esc>' .. post, { desc = 'Change word (to end) with last yanked text' })
map('n', 'cY', 'cW<C-r>0<Esc>' .. post, { desc = 'Change WORD (to end) with last yanked text' })
map('n', 'ciy', 'ciw<C-r>0<Esc>' .. post, { desc = 'Change inner word with last yanked text' })
map('n', 'ciY', 'ciW<C-r>0<Esc>' .. post, { desc = 'Change inner WORD with last yanked text' })
map('v', 'cy', 'c<C-r>0<Esc>' .. post, { desc = 'Replace selection with last yanked text' })

map('n', 'ss', '<cmd>write<CR>', { desc = 'Save file' })
map('n', '<C-g>', '<C-^>', { desc = 'Switch to alternate buffer' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' }) --  See `:help hlsearch`

-- Help
map('n', '<C-h>', ':help ', { desc = 'Open help' })
map('n', '<C-h><C-h>', ':help <C-r><C-w><CR>', { desc = 'Help for word under cursor' })
map('n', '<C-h><C-g>', ':helpgrep ', { desc = 'Helpgrep' })

-- Toggle Options
local opt_prefix = '<Leader>o'
--map('n', opt_pfx .. 'n', '<cmd>set number!<CR><cmd>echo "Toggle line numbers"<CR>', { desc = 'Toggle line numbers' })
map('n', opt_prefix .. 'n', ':set number!<CR>', { desc = 'Toggle line numbers' })
map('n', opt_prefix .. 'r', ':set relativenumber!<CR>', { desc = 'Toggle relative numbers' })
map('n', opt_prefix .. 'w', ':set wrap!<CR>', { desc = 'Toggle wrap' })
map('n', opt_prefix .. 't', ':set expandtab!<CR>', { desc = 'Toggle expandtab' })

-- TabPage
--  See `:help wincmd` for a list of all window commands
local tab_prefix = 't'
map('n', tab_prefix .. 'o', '<C-w>T', { desc = 'Detach tab to window' })
map('n', tab_prefix .. 't', '<cmd>tabedit<CR>', { desc = 'New tab' })
map('n', tab_prefix .. 'q', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', tab_prefix .. 'x', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })
map('n', tab_prefix .. 'n', '<cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', tab_prefix .. 'p', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', tab_prefix .. '.', '<cmd>tabmove +1<CR>', { desc = 'Move tab right' })
map('n', tab_prefix .. ',', '<cmd>tabmove -1<CR>', { desc = 'Move tab left' })
map('n', tab_prefix .. '>', '<cmd>tabmove<CR>', { desc = 'Move tab to last' })
map('n', tab_prefix .. '<', '<cmd>tabmove 0<CR>', { desc = 'Move tab to first' })
map('n', tab_prefix .. 's', '<cmd>split<CR>', { desc = 'Horizontal split' })
map('n', tab_prefix .. 'v', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', tab_prefix .. 'h', '<C-w>h', { desc = 'Move focus to left' })
map('n', tab_prefix .. 'l', '<C-w>l', { desc = 'Move focus to right' })
map('n', tab_prefix .. 'j', '<C-w>j', { desc = 'Move focus to lower' })
map('n', tab_prefix .. 'k', '<C-w>k', { desc = 'Move focus to upper' })
map('n', tab_prefix .. 'H', '<C-w>H', { desc = 'Move window to left' })
map('n', tab_prefix .. 'L', '<C-w>L', { desc = 'Move window to right' })
map('n', tab_prefix .. 'J', '<C-w>J', { desc = 'Move window to lower' })
map('n', tab_prefix .. 'K', '<C-w>K', { desc = 'Move window to upper' })
for i = 1, 9 do
  map('n', tab_prefix .. i, '<cmd>tabnext' .. i .. '<CR>', { desc = 'Go to tab ' .. i })
end

-- Terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-o><C-p>', '<C-w>""', { desc = 'Paste register in terminal' })

-- Tag
map('n', '<C-t><C-t>', '<C-]>', { desc = 'Tag jump' })
-- map('n', '<C-t>n', ':tag<CR>', { desc = 'Next tag' })
-- map('n', '<C-t>p', ':pop<CR>', { desc = 'Tag pop' })
-- map('n', '<C-t>l', ':tags<CR>', { desc = 'Show tag list' })

-- Gtags
map('n', '<C-l>', function()
  vim.cmd('cd ' .. vim.fn.getcwd())
  vim.cmd 'Gtags -f %'
end, { silent = true, desc = 'Regenerate Gtags for current file' })
map('n', '<C-j>', '<cmd>Gtags <C-r><C-w><CR>', { desc = 'Gtags symbol search' })
map('n', '<C-k>', '<cmd>Gtags -r <C-r><C-w><CR>', { desc = 'Gtags reverse search' })

-- Quickfix
map('n', '<C-n>', '<cmd>cn<CR>', { desc = 'QuickFix next item' })
map('n', '<C-p>', '<cmd>cp<CR>', { desc = 'QuickFix previous item' })
-- map('n', '<C-n>', '<cmd>cn<CR>zz', { desc = 'QuickFix next item' })
-- map('n', '<C-p>', '<cmd>cp<CR>zz', { desc = 'QuickFix previous item' })
map('n', 'so', '<cmd>colder<CR>', { desc = 'QuickFix older list' })
map('n', 'sn', '<cmd>cnewer<CR>', { desc = 'QuickFix newer list' })

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Restart neovim
map('n', '<leader>.', '<cmd>Restart<CR>', { desc = 'Restart Neovim' })

-- vim: ts=2 sts=2 sw=2 et
