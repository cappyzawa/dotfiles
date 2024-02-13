local wezterm = require("wezterm")
local act = wezterm.action

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

local tmux_keybinds = {
	-- Pane
	{ key = "\\", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	-- { key = "r", mods = "LEADER", action = wezterm.action {
	--   ActivateKeyTable = {
	--     name = "resize_pane",
	--     one_shot = false,
	--   }
	-- } },

	-- Tab
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{
		key = ",",
		mods = "LEADER",
		action = act.Multiple({
			act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		}),
	},
	{ key = "h", mods = "LEADER|CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "LEADER|CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "[", mods = "LEADER|CTRL", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "]", mods = "LEADER|CTRL", action = wezterm.action({ MoveTabRelative = 1 }) },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
}

local termainl_keybinds = {
	-- Font Size
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },

	{ key = "q", mods = "CMD", action = "QuitApplication" },

	-- Operation
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "y", mods = "LEADER", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "p", mods = "LEADER", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "v", mods = "LEADER", action = "ActivateCopyMode" },
	{ key = "/", mods = "LEADER", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{ key = "P", mods = "CTRL", action = wezterm.action.ActivateCommandPalette },
}

local keybinds = function()
	local list = {}
	for _, v in ipairs(tmux_keybinds) do
		table.insert(list, v)
	end
	for _, v in ipairs(termainl_keybinds) do
		table.insert(list, v)
	end
	return list
end

-- wezterm.on("update-right-status", function(window, pane)
-- 	-- Each element holds the text for a cell in a "powerline" style << fade
-- 	local cells = {}
--
-- 	table.insert(cells, "")
-- 	table.insert(cells, "")
--
-- 	local date = wezterm.strftime("%a %b %-d %H:%M")
-- 	table.insert(cells, date)
--
-- 	-- An entry for each battery (typically 0 or 1 battery)
-- 	for _, b in ipairs(wezterm.battery_info()) do
-- 		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
-- 	end
--
-- 	-- Color palette for the backgrounds of each cell
-- 	local colors = {
-- 		"#1a1b26",
-- 		"#e0af68",
-- 		"#1a1b26",
-- 		"#e0af68",
-- 	}
--
-- 	-- Foreground color for the text across the fade
-- 	local text_fg = "#414868"
--
-- 	-- The elements to be formatted
-- 	local elements = {}
-- 	-- How many cells have been formatted
-- 	local num_cells = 0
--
-- 	-- Translate a cell into elements
-- 	local function push(text, is_last)
-- 		local cell_no = num_cells + 1
-- 		table.insert(elements, { Foreground = { Color = text_fg } })
-- 		table.insert(elements, { Background = { Color = colors[cell_no] } })
-- 		table.insert(elements, { Text = " " .. text .. " " })
-- 		if not is_last then
-- 			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
-- 			table.insert(elements, { Text = SOLID_LEFT_ARROW })
-- 		end
-- 		num_cells = num_cells + 1
-- 	end
--
-- 	while #cells > 0 do
-- 		local cell = table.remove(cells, 1)
-- 		push(cell, #cells == 0)
-- 	end
--
-- 	window:set_right_status(wezterm.format(elements))
-- end)

return {
	color_scheme = "Tokyo Night",
	window_frame = {
		font = wezterm.font("Moralerspace Argon NF"),
		font_size = 20.0,

		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = "#1a1b26",
		active_titlebar_fg = "#c0caf5",
	},
	font = wezterm.font("Moralerspace Argon NF"),
	font_size = 20.0,
	harfbuzz_features = { "zero" },
	bold_brightens_ansi_colors = true,

	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 16,
	window_padding = {
		left = 20,
		right = 20,
		top = 0,
		bottom = 0,
	},
	disable_default_key_bindings = true,
	check_for_updates = false,
	cursor_blink_rate = 0,
	animation_fps = 5,

	leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keybinds(),
	key_tables = {
		resize_pane = {
			{ key = "h", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
			{ key = "l", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
			{ key = "k", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
			{ key = "j", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
			{ key = "Escape", action = "PopKeyTable" },
		},
		copy_mode = {
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					act.CopyTo("ClipboardAndPrimarySelection"),
					act.ClearSelection,
					act.CopyMode("ClearSelectionMode"),
				}),
			},
		},
		search_mode = {
			{ key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
			{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
			{ key = "j", mods = "CTRL", action = wezterm.action({ CopyMode = "NextMatchPage" }) },
			{ key = "k", mods = "CTRL", action = wezterm.action({ CopyMode = "PriorMatch" }) },
		},
	},
}
