# TODO

## All

* vimrcを反映する
* キーマップを設定する
* Filerの設定
* lazy-pluginを整理する
pluginsにプラグイン格納場所を統合する
	customeの削除
	kickstart削除
* copilot を補完して使う
* LSPをの有効無効を簡単にする
* debugできるようにする。

* markを一覧する
* NerdFontを有効にする(which-keyなどで見た目が変わるか確認する)

* auto completeの表示を消す<ESC>
* 現在のファイル内の%をステータスラインに表示する
* 現在のバッファのディレクトリでターミナルを開く

## mini.surround
helpを見る

## copilot.lua

* keymap.dismissの確定(補完系と合わせる.<C-E>など)

## copilot-chat.lua
* Tanslateをキーマッピングする
* Markdown Rendering  
https://github.com/CopilotC-Nvim/CopilotChat.nvim/wiki/Examples-and-Tips

## telescope
### 酢の文字列を検索する
require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--fixed-strings',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
})

## Read Later

https://xcr4k.hatenablog.com/entry/2025/03/03/155037
