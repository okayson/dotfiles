-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Hold the configuration.
local config = wezterm.config_builder()

-----------------------------------------------
-- Configuration
-----------------------------------------------

config.default_domain = "WSL:Ubuntu"
-- local default_cwd = os.getenv("HOME")
-- config.default_cwd = default_cwd

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.use_ime = true

-- Color scheme
-- 	find in https://wezterm.org/colorschemes/index.html
-- config.color_scheme = "Adventure"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Ubuntu"
-- config.color_scheme = "Maia (Gogh)"
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Kanagawa (Gogh)"

config.initial_rows = 20
config.initial_cols = 120

-- config.window_decorations = "RESIZE"
config.enable_scroll_bar = true
config.window_close_confirmation = "AlwaysPrompt"

-- フォントの設定
config.font = wezterm.font_with_fallback({
	"HackGen Console NF", -- https://github.com/yuru7/HackGen
	"Hack Nerd Font", -- https://www.nerdfonts.com/font-downloads
	"Symbols Nerd Font", -- https://www.nerdfonts.com/font-downloads
	"MyricaM M", -- https://myrica.estable.jp/myricamhistry/
	"Consolas",
})

-- フォントサイズの設定
config.font_size = 12

-- 背景の透過
-- config.window_background_opacity = 0.95

-- 非フォーカスペインの色調補正
-- config.colors = {
-- 	inactive_pane_hsb = {
-- 		-- 色相（Hue）はそのまま
-- 		saturation = 0.0,   -- 彩度を下げて灰色っぽく
-- 		brightness = 0.2,   -- 明るさを下げる（黒に近い）
-- 	},
-- }

-- Tab Bar: タブ1つの場合は非表示
config.hide_tab_bar_if_only_one_tab = true
-- Tab Bar: の追加ボタンを消す
config.show_new_tab_button_in_tab_bar = false
-- Tab Bar: 削除ボタンを消す(nightlyでのみ使用可能)
--config.show_close_tab_button_in_tabs = false

config.use_fancy_tab_bar = false -- Tab Style
config.tab_bar_at_bottom = true
config.tab_max_width = 100

-- config.colors = {
--   tab_bar = {
--     inactive_tab_edge = "none",
--   },
-- }

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle -- Tab Style
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle -- Tab Style

-- アクティブタブに色を付ける
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	-- local background = "#696969"
	local foreground = "#C0C0C0"
	local edge_background = "none" -- Tab Style

	if tab.is_active then
		background = "#ae8b2d" -- Pattern.1
		-- background = "#4682b4" -- steelblue
		-- background = "#4169e1" -- royalblue
		-- background = "#3cb371" -- mediumseagreen
		-- background = "#2e8b57" -- seagreen
		foreground = "#FFFFFF"
	end

	local edge_foreground = background -- Tab Style
	-- local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "

	return {

		{ Background = { Color = edge_background } }, -- Tab Style
		{ Foreground = { Color = edge_foreground } }, -- Tab Style
		{ Text = SOLID_LEFT_ARROW }, -- Tab Style
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } }, -- Tab Style
		{ Foreground = { Color = edge_foreground } }, -- Tab Style
		{ Text = SOLID_RIGHT_ARROW }, -- Tab Style
	}
end)

-- カーソルの設定
config.default_cursor_style = "BlinkingBlock"
-- config.default_cursor_style = 'BlinkingUnderline'

config.colors = {
	cursor_fg = "#11111b",
	cursor_bg = "#59c2c6",
	cursor_border = "#59c2c6",
}

-- prefixキーの設定
config.leader = {
	mods = "ALT",
	key = ";",
	timeout_milliseconds = 2000,
}

config.launch_menu = {
	{
		label = "New Tab: PowerShell",
		domain = { DomainName = "local" },
		args = { "pwsh.exe", "-NoLogo" },
	},
	{
		label = "New Tab: WSL",
		domain = { DomainName = "WSL:Ubuntu" },
	},
}

-- キーバインド
config.keys = {
	-- Launch Menu
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" }),
	},
	-- activate copy mode or vim mode
	-- Vで選択開始し、カーソル移動して、yでyankする
	{
		mods = "LEADER",
		key = "y",
		action = wezterm.action.ActivateCopyMode,
	},
	-- quick select (tmux-fingers)
	{
		mods = "LEADER",
		key = "f",
		action = wezterm.action.QuickSelect,
	},
	-- フォント拡大
	{
		mods = "ALT|SHIFT",
		key = "+",
		action = wezterm.action.IncreaseFontSize,
	},
	-- フォント縮小
	{
		mods = "ALT",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
	-- フォントリセット
	{
		mods = "ALT|SHIFT",
		key = "=",
		action = wezterm.action.ResetFontSize,
	},
	-- 新しいタブを開く
	{
		mods = "ALT",
		key = "t",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.SpawnCommandInNewTab({
			domain = { DomainName = "local" },
			args = { "pwsh.exe", "-NoLogo" },
		}),
	},
	-- 次のタブに移動
	{
		mods = "ALT",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- 前のタブに移動
	{
		mods = "ALT",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- ペイン分割(左右)
	{
		mods = "ALT",
		key = "v",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	-- ペイン分割(上下)
	{
		mods = "ALT",
		key = "s",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- ペインを閉じる
	{
		mods = "ALT",
		key = "q",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- ペイン間移動
	{
		mods = "ALT",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "ALT",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "ALT",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "ALT",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- ペイン移動(時計回り)
	{
		mods = "ALT",
		key = "r",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- ペイン移動(反時計回り)
	{
		mods = "ALT",
		key = "R",
		action = wezterm.action.RotatePanes("CounterClockwise"),
	},
	-- ペイン境界の調整
	{
		mods = "ALT",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
	},
	{
		mods = "ALT",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
	},
	{
		mods = "ALT",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		mods = "ALT",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
	},
}

-- マウス操作
config.mouse_bindings = {
	-- 右クリックでクリップボードから貼り付け
	{
		mods = "NONE",
		event = { Down = { streak = 1, button = "Right" } },
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	--	-- フォント拡大
	--	{
	--		mods = "ALT",
	--		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
	--		action = wezterm.action.IncreaseFontSize,
	--	},
	--	-- フォント縮小
	--	{
	--		mods = "ALT",
	--		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
	--		action = wezterm.action.DecreaseFontSize,
	--	},
	--	-- フォントリセット
	--	{
	--		event = { Down = { streak = 1, button = "Middle" } },
	--		action = wezterm.action.ResetFontSize,
	--	},
}

-- Finally, return the configuration to wezterm:
return config
