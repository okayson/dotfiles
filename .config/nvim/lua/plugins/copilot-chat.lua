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
  },
  config = function()

    local default_prompts = require("CopilotChat.config.prompts")
    local in_japanese = "なお、必ず日本語で回答してください。"
                        .. "専門用語は必要に応じて英語を併記してください。"
                        .. "不確実な点は推測であることを明記してください。"

    require("CopilotChat").setup({
      language = 'Japanese', -- Hint
      show_help = 'yes',

        -- ビルトインのプロンプトを日本語化
        prompts = vim.tbl_deep_extend("force", default_prompts, {
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
            prompt =
            "Translate the selected text from English to Japanese if it is in English, "
            .. "or from Japanese to English if it is in Japanese. "
            .. "Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.",
            system_prompt =
            "You are an excellent Japanese-English translator. "
            .. "You can translate the original text correctly without losing its meaning. "
            .. "You also have deep knowledge of system engineering and are good at translating technical documents.",
            description = "Translate text from Japanese to English or vice versa",
        },
    }),
  })
  end,
}
