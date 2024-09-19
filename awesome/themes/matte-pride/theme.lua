local awful = require("awful")
local gears = require("gears")
local cairo = require("lgi").cairo
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
--local themes_path = gfs.get_themes_dir()  HECK this
local themes_path = gfs.get_configuration_dir() .. "themes/"
local bar = require("themes.matte-pride.bar")

math.randomseed(os.time())

local theme = {}

theme.font          = "Fira Mono 10"
--Is this the most bodged thing I've ever done? Proly not. Added a custom font
--variable just for XFT formatting (for dmenu)
--theme.xft_font      = "Fira Mono:size=10"

theme.bg_normal     = "#3d3d3d"
theme.bg_focus      = "#303030"
theme.bg_urgent     = "#f89341"
theme.bg_minimize   = "#000000"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#000000"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#f99442"

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(2)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Hotkey/"help" window theming
theme.hotkeys_modifiers_fg = theme.fg_normal
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_border_width = dpi(1)
theme.hotkeys_border_color = theme.fg_normal

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."matte-pride/gsubmenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."matte-pride/gtitlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."matte-pride/gtitlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."matte-pride/gtitlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."matte-pride/gtitlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."matte-pride/gtitlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."matte-pride/gtitlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."matte-pride/gtitlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."matte-pride/gtitlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."matte-pride/gtitlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."matte-pride/gtitlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."matte-pride/gtitlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."matte-pride/gtitlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."matte-pride/gtitlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."matte-pride/gtitlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."matte-pride/gtitlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."matte-pride/gtitlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."matte-pride/gtitlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."matte-pride/gtitlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."matte-pride/gtitlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."matte-pride/gtitlebar/maximized_focus_active.png"
-- theme.wallpaper = themes_path.."space/background.jpg"
theme.background_color = "#3d3d3d"
theme.highlight_colors = {};
theme.highlight_colors[1] = {bg_normal = "#ed8e89", bg_focus = "#f4b6b3"}
theme.highlight_colors[2] = {bg_normal = "#f7b685", bg_focus = "#fad4b7"}
theme.highlight_colors[3] = {bg_normal = "#f3eba5", bg_focus = "#f9f5d2"}
theme.highlight_colors[4] = {bg_normal = "#94c691", bg_focus = "#b4d7b2"}
theme.highlight_colors[5] = {bg_normal = "#9bd6d9", bg_focus = "#c0e5e7"}
theme.highlight_colors[6] = {bg_normal = "#b4a8e0", bg_focus = "#d5ceee"}
theme.background_bar_width = dpi(50)
theme.background_bar_position = 0.7

theme.wallpaper = function (screen)
    local geometry, context = gears.wallpaper.prepare_context(screen)
    local bar_width = theme.background_bar_width
    local bar_surface = cairo.ImageSurface.create(cairo.Format.ARGB32, bar_width * #theme.highlight_colors, geometry.height*2)
    local bar_context = cairo.Context(bar_surface)
    for index, color in pairs(theme.highlight_colors) do
        bar_context:set_source(gears.color(color.bg_normal))
        bar_context:rectangle((index - 1) * bar_width, 0, bar_width, geometry.height*2)
        bar_context:fill()
    end
    context:set_source(gears.color({type="linear", from = {0,0}, to = {0, geometry.height}, stops = { { 0, theme.background_color }, { 1, "#202020" } } }))
    context:rectangle(0, 0, geometry.width, geometry.height)
    context:fill()
    context:set_source_surface(bar_surface,0,0)
    local pattern = context:get_source()
    local x_offset = math.random(geometry.width)
    local rotation = math.random(-2,2) * 0.2618
    pattern:set_matrix(gears.matrix.identity:rotate(rotation):translate(-x_offset,200):to_cairo_matrix())
    context:rectangle(0,0, geometry.width, geometry.height)
    context:fill()
end

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."matte-pride/glayouts/fairhw.png"
theme.layout_fairv = themes_path.."matte-pride/glayouts/fairvw.png"
theme.layout_floating  = themes_path.."matte-pride/glayouts/floatingw.png"
theme.layout_magnifier = themes_path.."matte-pride/glayouts/magnifierw.png"
theme.layout_max = themes_path.."matte-pride/glayouts/maxw.png"
theme.layout_fullscreen = themes_path.."matte-pride/glayouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."matte-pride/glayouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."matte-pride/glayouts/tileleftw.png"
theme.layout_tile = themes_path.."matte-pride/glayouts/tilew.png"
theme.layout_tiletop = themes_path.."matte-pride/glayouts/tiletopw.png"
theme.layout_spiral  = themes_path.."matte-pride/glayouts/spiralw.png"
theme.layout_dwindle = themes_path.."matte-pride/glayouts/dwindlew.png"
theme.layout_cornernw = themes_path.."matte-pride/glayouts/cornernww.png"
theme.layout_cornerne = themes_path.."matte-pride/glayouts/cornernew.png"
theme.layout_cornersw = themes_path.."matte-pride/glayouts/cornersww.png"
theme.layout_cornerse = themes_path.."matte-pride/glayouts/cornersew.png"

--notification
theme.notification_icon_size=50
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

--export bar widget so rc.lua can connect.
theme.bar = bar

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

tag.connect_signal("property::selected", function(t)
    if t.selected then
        local normal = theme.highlight_colors[t.index].bg_normal
        local focus = theme.highlight_colors[t.index].bg_focus
        theme.bg_normal = normal
        theme.bg_focus = focus
        theme.border_normal = normal
        theme.border_focus = focus
        theme.bg_systray = normal
    end
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
