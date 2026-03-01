-- [[ Basic Usercommands ]]
--  See `:help lua-guide-command

-- [[ Restart ]]
-- Restart Neovim while preserving the current session.
vim.api.nvim_create_user_command('Restart', function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype ~= '' then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
  -- Check if there is already an active session.
  -- If there is already an active session, it will use that instead of creating a temporary one.
  local has_session = vim.v.this_session ~= nil and vim.v.this_session ~= ''
  local session = has_session and vim.v.this_session or vim.fs.joinpath(tostring(vim.fn.stdpath 'state'), 'restart_session.vim')

  vim.fn.mkdir(vim.fs.dirname(session), 'p')
  vim.cmd.mksession { args = { session }, bang = true }

  -- Delete only temporary sessions.
  -- There is no need to clear this_session when using an existing session.
  if not has_session then
    local session_x = string.gsub(session, '%.vim$', 'x.vim')
    vim.fn.writefile({ 'let v:this_session = ""' }, session_x)
  end
  vim.cmd.restart { args = { 'source', session } }
end, { desc = 'Restart current Neovim session' })

-- [[ DeleteNvimLogs ]]
-- Clear Neovim log files in the standard log directory.
vim.api.nvim_create_user_command('DeleteNvimLogs', function()
  local log_dir = vim.fn.stdpath 'log'
  local log_files = vim.fn.globpath(log_dir, '*.log', true, true)

  print('Delete Neovim logs in ' .. log_dir)
  for _, file in ipairs(log_files) do
    os.remove(file)
    print('  ' .. file)
  end
end, { desc = 'Clear Neovim log files' })

-- [[ TrimSpaces ]]
-- Trim trailing whitespace in the current buffer or a specified range.
vim.api.nvim_create_user_command('TrimSpaces', function(opts)
  vim.cmd(string.format('%d,%ds/\\s\\+$//e', opts.line1, opts.line2))
end, { range = '%', desc = 'Trim trailing whitespace' })

-- [[ CD ]]
vim.api.nvim_create_user_command('Tcd', function()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path == '' then
    print 'Current buffer has no name. Cannot change directory.'
    return
  end
  local dir = vim.fs.dirname(buf_path)
  vim.cmd.tcd(dir)
end, { desc = 'tcd with current buffer' })

vim.api.nvim_create_user_command('Lcd', function()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path == '' then
    print 'Current buffer has no name. Cannot change directory.'
    return
  end
  local dir = vim.fs.dirname(buf_path)
  vim.cmd.lcd(dir)
end, { desc = 'lcd with current buffer' })

-- vim: ts=2 sts=2 sw=2 et
