hl.monitor({
	output = "DP-1",
	mode = "3440x1440@165",
	-- position = "0x0",
	scale = 1,
})

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("GRIMBLAST_EDITOR", "swappy -f")
hl.env("XDG_SCREENSHOTS_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita:dark")

hl.env("LIBVA_DRIVER_NAME", "nvidia")

hl.on("hyprland.start", function()
  --
--exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
--exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
--exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
--exec-once = mako
--exec-once = blueman-applet
--exec-once = nm-applet --indicator
--exec-once = wl-paste --watch cliphist store
--exec-once = ~/dotfiles/general/init
--

	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	hl.exec_cmd("mako &")
	hl.exec_cmd("blueman-applet &")
	hl.exec_cmd("nm-applet --indicator &")
	hl.exec_cmd("wl-paste --watch cliphist store &")
  hl.exec_cmd("waybar --config ~/dotfiles/general/waybar/conf/main.jsonc --style ~/dotfiles/general/waybar/style/style.css &")
  hl.exec_cmd("waybar --config ~/dotfiles/general/waybar/conf/main-bottom.jsonc --style ~/dotfiles/general/waybar/style/style.css &")
  hl.exec_cmd("awww-daemon &")
end)

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 10,
		border_size = 2,

		col = {
			active_border = "rgb(cdd6f4)",
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		blur = {
			enabled = false,
			size = 7,
			passes = 1,
			new_optimizations = true,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		enable_anr_dialog = false,
	},

	cursor = {
		no_hardware_cursors = false,
		use_cpu_buffer = true,
	},

	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0.1,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.config({ animations = { enabled = true } })

hl.curve("myBezier", { type = "bezier", points = { { 0.10, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.window_rule({ match = { class = "^kitty$" }, opacity = "0.95" })
hl.window_rule({ match = { class = ".*" }, opacity = "1 0.95" })
hl.window_rule({ match = { fullscreen = true }, opacity = "1" })

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + X", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + C", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client --toggle"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("wofi"))

hl.bind(
	mainMod .. " + S",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave area "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png"'
	)
)
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave active "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png"'
	)
)
hl.bind(
	mainMod .. " + CTRL + SHIFT + S",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave screen "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png"'
	)
)

hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave area "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png" && wl-paste | swappy -f -'
	)
)
hl.bind(
	mainMod .. " + SHIFT + D",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave active "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png" && wl-paste | swappy -f -'
	)
)
hl.bind(
	mainMod .. " + CTRL + SHIFT + D",
	hl.dsp.exec_cmd(
		'grimblast --notify --freeze copysave screen "$HOME/Pictures/Screenshots/$(date +%F_%T_%3N).png" && wl-paste | swappy -f -'
	)
)

hl.bind(
	mainMod .. " + B",
	hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy")
)
hl.bind(
	mainMod .. " + P",
	hl.dsp.exec_cmd(
		'color=$(hyprpicker -n) && magick -size 40x40 xc:"$color" /tmp/color.png && notify-send "Selected Color: $color" -i /tmp/color.png && wl-copy $color'
	)
)
