-- See Below
-- vscode-neovim APIs
--  https://github.com/vscode-neovim/vscode-neovim?tab=readme-ov-file#%EF%B8%8F-api
--  AlterCommand
--  https://github.com/search?q=repo%3Avscode-neovim%2Fvscode-neovim%20AlterCommand&type=code

local M = {}

function M.setup()

    local vscode = require('vscode')
    if not vscode then
        return
    end

    -- =========================
    -- TabPage
    -- =========================
    local TabPage = '[TabPage]'
    vim.keymap.set('n', TabPage, '<Nop>')
    vim.keymap.set('n', 't', TabPage, {remap = true})
    
    -- 新しいタブ 
    vim.keymap.set('n', TabPage..'t', function() vscode.call('workbench.action.quickOpen') end, { silent = true })

    -- タブ閉じる
    vim.keymap.set('n', TabPage..'q', function() vscode.call('workbench.action.closeActiveEditor') end, { silent = true })

    -- 他のタブを閉じる
    vim.keymap.set('n', TabPage..'x', function() 
        vscode.call('workbench.action.closeEditorsInOtherGroups') 
        vscode.call('workbench.action.closeOtherEditors') 
    end, { silent = true })

    -- 次のタブ / 前のタブ
    -- vim.keymap.set('n', TabPage..'n', function() vscode.call('workbench.action.nextEditor') end, { silent = true })
    -- vim.keymap.set('n', TabPage..'p', function() vscode.call('workbench.action.previousEditor') end, { silent = true })
    vim.keymap.set('n', TabPage..'n', function() vscode.call('workbench.action.nextEditorInGroup') end, { silent = true })
    vim.keymap.set('n', TabPage..'p', function() vscode.call('workbench.action.previousEditorInGroup') end, { silent = true })

    -- タブ一覧表示
    vim.keymap.set('n', TabPage..'i', function() vscode.call('workbench.action.showAllEditors') end, { silent = true })

    -- 数字キーでタブ移動（1〜9）
    for i = 1, 9 do
        vim.keymap.set('n', TabPage..i, function()
            vscode.call('workbench.action.openEditorAtIndex' .. i)
        end, { silent = true })
    end

    -- =========================
    -- Neovim ウィンドウ操作
    -- =========================
    vim.keymap.set('n', TabPage..'s', function() vscode.call('workbench.action.splitEditorDown') end, { silent = true })    -- 横分割
    vim.keymap.set('n', TabPage..'v', function() vscode.call('workbench.action.splitEditorRight') end, { silent = true })   -- 縦分割
    vim.keymap.set('n', TabPage..'j', function() vscode.call('workbench.action.focusBelowGroup') end, { silent = true })    -- 下移動
    vim.keymap.set('n', TabPage..'k', function() vscode.call('workbench.action.focusAboveGroup') end, { silent = true })    -- 上移動
    vim.keymap.set('n', TabPage..'h', function() vscode.call('workbench.action.focusLeftGroup') end, { silent = true })     -- 左移動
    vim.keymap.set('n', TabPage..'l', function() vscode.call('workbench.action.focusRightGroup') end, { silent = true })    -- 右移動

    -- =========================
    -- Neovim タブ順序変更
    -- =========================
    vim.keymap.set('n', TabPage..'.', function() vscode.call('workbench.action.moveEditorRightInGroup') end, { silent = true })
    vim.keymap.set('n', TabPage..',', function() vscode.call('workbench.action.moveEditorLeftInGroup') end, { silent = true })
    vim.keymap.set('n', TabPage..'>', function() vscode.call('workbench.action.moveEditorToRightGroup') end, { silent = true })
    vim.keymap.set('n', TabPage..'<', function() vscode.call('workbench.action.moveEditorToLeftGroup') end, { silent = true })
end

M.setup()

return M
