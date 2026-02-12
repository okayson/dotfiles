return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  cmd = {
    'CopilotChat',
    'CopilotChatOpen',
    'CopilotChatToggle',
  },
  keys = {
    { '<leader>cc', mode = { 'n', 'x' }, ':CopilotChat', desc = 'CopilotChat' },
    { '<leader>ce', mode = { 'n', 'x' }, '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat Explain' },
    { '<leader>cr', mode = { 'n', 'x' }, '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat Review' },
    { '<leader>cf', mode = { 'n', 'x' }, '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat Fix' },
    { '<leader>co', mode = { 'n', 'x' }, '<cmd>CopilotChatOptimize<cr>', desc = 'CopilotChat Optimize' },
    { '<leader>cd', mode = { 'n', 'x' }, '<cmd>CopilotChatDocs<cr>', desc = 'CopilotChat Docs' },
    { '<leader>ct', mode = { 'n', 'x' }, '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat Tests' },
    { '<leader>cm', mode = { 'n', 'x' }, '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat Commit Message' },
    { '<leader>cp', mode = { 'n', 'x' }, '<cmd>CopilotChatPrompt<cr>', desc = 'CopilotChat Prompts' },
    { '<leader>ch', mode = { 'n', 'x' }, '<cmd>CopilotChatHistory<cr>', desc = 'CopilotChat History(newest)' },
    { '<leader>cH', mode = { 'n', 'x' }, '<cmd>CopilotChatHistory oldest<cr>', desc = 'CopilotChat History (oldest)' },
  },
  config = function()
    local default_prompts = require 'CopilotChat.config.prompts'
    local in_japanese = 'なお、必ず日本語で回答してください。'
      .. '専門用語は必要に応じて英語を併記してください。'
      .. '不確実な点は推測であることを明記してください。'

    require('CopilotChat').setup {
      language = 'Japanese', -- Hint
      show_help = 'yes',

      -- ビルトインのプロンプトを日本語化
      prompts = vim.tbl_deep_extend('force', default_prompts, {
        Explain = {
          prompt = default_prompts.Explain.prompt .. in_japanese,
        },
        Review = {
          prompt = default_prompts.Review.prompt .. in_japanese,
        },
        Fix = {
          prompt = default_prompts.Fix.prompt .. in_japanese,
        },
        Optimize = {
          prompt = default_prompts.Optimize.prompt .. in_japanese,
        },
        Docs = {
          prompt = default_prompts.Docs.prompt .. in_japanese,
        },
        Tests = {
          prompt = default_prompts.Tests.prompt .. in_japanese,
        },
        Commit = {
          prompt = default_prompts.Commit.prompt .. in_japanese,
        },

        -- 日英翻訳
        TranslateJE = {
          prompt = 'Translate the selected text from English to Japanese if it is in English, '
            .. 'or from Japanese to English if it is in Japanese. '
            .. 'Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.',
          system_prompt = 'You are an excellent Japanese-English translator. '
            .. 'You can translate the original text correctly without losing its meaning. '
            .. 'You also have deep knowledge of system engineering and are good at translating technical documents.',
          description = 'Translate text from Japanese to English or vice versa',
        },
      }),
    }

    local function copilotchat_history_dir(opts)
      local ok, chat = pcall(require, 'CopilotChat')
      if not ok or not chat.config or not chat.config.history_path then
        if opts and opts.notify then
          vim.notify('CopilotChat is not initialized', vim.log.levels.ERROR)
        end
        return nil
      end

      local history_dir = chat.config.history_path
      if vim.fn.isdirectory(history_dir) == 0 then
        return nil
      end

      return history_dir
    end

    local function copilotchat_history_list()
      local history_dir = copilotchat_history_dir()
      if not history_dir then
        return {}
      end

      local files = vim.fn.glob(history_dir .. '/*.json', false, true)
      return vim.tbl_map(function(path)
        return vim.fn.fnamemodify(path, ':t:r') -- hoge.json -> hoge
      end, files)
    end

    local function copilotchat_confirm(prompt, choices, default_choice)
      local ok, confirm = pcall(vim.fn.confirm, prompt, choices, default_choice)
      vim.cmd 'redraw' -- Clear 'Press ENTER or type command to continue'.
      if not ok then
        return nil
      end

      return confirm
    end

    local function copilotchat_relative_time(epoch_seconds)
      if not epoch_seconds or epoch_seconds <= 0 then
        return 'unknown'
      end

      local now = os.time()
      local diff = now - epoch_seconds
      if diff < 0 then
        diff = 0
      end

      local minute = 60
      local hour = 60 * minute
      local day = 24 * hour

      if diff < minute then
        return 'just now'
      elseif diff < hour then
        local mins = math.floor(diff / minute)
        return string.format('%d minute%s ago', mins, mins == 1 and '' or 's')
      elseif diff < day then
        local hours = math.floor(diff / hour)
        return string.format('%d hour%s ago', hours, hours == 1 and '' or 's')
      end

      local days = math.floor(diff / day)
      return string.format('%d day%s ago', days, days == 1 and '' or 's')
    end

    local history_orders = { 'newest', 'oldest' }

    local function copilotchat_history_order(arg)
      if vim.tbl_contains(history_orders, arg) then
        return arg
      end

      return 'newest'
    end

    -- CopilotChatDelete
    vim.api.nvim_create_user_command('CopilotChatDelete', function(opts)
      local name = opts.args
      if name == '' then
        vim.notify('Session name required', vim.log.levels.WARN)
        return
      end

      local history_dir = copilotchat_history_dir { notify = true }
      if not history_dir then
        return
      end

      local path = history_dir .. '/' .. name .. '.json'
      if vim.fn.filereadable(path) == 0 then
        vim.notify('Session not found: ' .. name, vim.log.levels.ERROR)
        return
      end

      local confirm = copilotchat_confirm("Delete CopilotChat session '" .. name .. "'?", '&Yes\n&No', 2)
      if confirm ~= 1 then
        vim.notify('Canceled deletion: ' .. name)
        return
      end

      local ok_rm, err = os.remove(path)
      if ok_rm then
        vim.notify('Deleted CopilotChat session: ' .. name)
      else
        vim.notify('Failed to delete: ' .. (err or name), vim.log.levels.ERROR)
      end
    end, {
      nargs = 1,
      -- Tab completion (same source as CopilotChatLoad)
      complete = function(arglead, _, _)
        return vim.tbl_filter(function(item)
          return item:find('^' .. vim.pesc(arglead))
        end, copilotchat_history_list())
      end,
    }) -- End of CopilotChatDelete

    -- CopilotChatHistory
    vim.api.nvim_create_user_command('CopilotChatHistory', function(opts)
      local order = copilotchat_history_order(opts.args)

      local history_dir = copilotchat_history_dir()
      if not history_dir then
        vim.notify('No CopilotChat history found', vim.log.levels.INFO)
        return
      end

      local items = copilotchat_history_list()
      if vim.tbl_isempty(items) then
        vim.notify('No CopilotChat history found', vim.log.levels.INFO)
        return
      end

      local item_times = {}
      for _, item in ipairs(items) do
        item_times[item] = vim.fn.getftime(history_dir .. '/' .. item .. '.json')
      end

      -- Sort by order
      table.sort(items, function(a, b)
        local a_time = item_times[a]
        local b_time = item_times[b]
        if order == 'newest' then
          return a_time > b_time
        end

        return a_time < b_time
      end)

      -- Select History
      vim.ui.select(items, {
        prompt = 'CopilotChat History (order: ' .. order .. '):',
        format_item = function(item)
          return string.format('%s (%s)', item, copilotchat_relative_time(item_times[item]))
        end,
      }, function(choice)
        if not choice then
          return
        end

        -- Select Action
        local action = copilotchat_confirm("Action for '" .. choice .. "'?", '&Load\n&Save\n&Delete\n&Cancel', 4)

        if not action then
          return
        elseif action == 1 then
          vim.cmd 'CopilotChatOpen'
          vim.cmd('CopilotChatLoad ' .. choice)
        elseif action == 2 then
          vim.cmd('CopilotChatSave ' .. choice)
        elseif action == 3 then
          vim.cmd('CopilotChatDelete ' .. choice)
        end
      end)
    end, {
      nargs = '?',
      complete = function(arglead, _, _)
        return vim.tbl_filter(function(item)
          return item:find('^' .. vim.pesc(arglead))
        end, history_orders)
      end,
    }) -- End of CopilotChatHistory
  end,
}
