local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
-- holy shit what the fuck
package.path = package.path .. ";/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua"
local vicious = require("vicious")
local dpi = xresources.apply_dpi

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- WIBAR
return function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 5,
                right = 5,
                widget = wibox.container.margin
            },
            id = "custom_background",
            widget = wibox.container.background,
            create_callback = function(self, _, index, _)
                local color = beautiful.highlight_colors[index].bg_normal
                self:get_children_by_id('custom_background')[1].bg = color
            end,
            update_callback = function(self, t, index, _)
                local bg_normal = beautiful.highlight_colors[index].bg_normal
                local bg_focus = beautiful.highlight_colors[index].bg_focus
                if t.selected then
                    self:get_children_by_id('custom_background')[1].bg = bg_focus
                else
                    self:get_children_by_id('custom_background')[1].bg = bg_normal
                end
            end
        }
    }

    s.systray = wibox.widget.systray()
    s.textclock = wibox.widget {
        font = "Fira Mono 12",
        widget = wibox.widget.textbox
    }
    --vicious.cache(vicious.contrib.cmus_all)
    local CMUS_SOCKET = os.getenv("XDG_RUNTIME_DIR") .. "/cmus-socket"
    vicious.register(s.textclock, vicious.widgets.cmus,
                function (widget, args)
                    if args["{status}"] ~= "playing" then
                        return os.date("%a %b %d %H:%M")
                    else
                        return ("%s - %s"):format(args["{artist}"], args["{title}"])
                    end
                end,
                13, {CMUS_SOCKET})
    s.memwidget = wibox.widget {
        foot = "Fira Mono 10",
        widget = wibox.widget.textbox
    }
    vicious.cache(vicious.widgets.mem)
    vicious.register(s.memwidget, vicious.widgets.mem, "$1% Memory", 7)
    s.cpuwidget = wibox.widget {
        font = "Fira Mono 10",
        widget = wibox.widget.textbox
    }
    vicious.cache(vicious.widgets.cpu)
    vicious.register(s.cpuwidget, vicious.widgets.cpu, "$1% CPU", 11)
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s, width = "99%", height= dpi(30),
        shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,beautiful.border_radius) end,
        margins = { bottom = beautiful.useless_gap }
    })

    -- Recolor title bar anytime we change tags
    tag.connect_signal("property::selected", function(t)
        -- t.screen == s allows us to limit the color change to the screen the
        -- tag is on
        if t.selected and t.screen == s then
            s.mywibox.bg = beautiful.highlight_colors[t.index].bg_normal
            beautiful.bg_systray = beautiful.highlight_colors[t.index].bg_normal
            --beautiful.tasklist_bg_normal = beautiful.highlight_colors[t.index].bg_normal
            --beautiful.tasklist_bg_focus = beautiful.highlight_colors[t.index].bg_focus
        end
    end)

    --[[
    s.wiboxborder = wibox.container.margin({widget=s.mywibox,
        left=dpi(5),
        right=dpi(5),
        top=dpi(10)})]]--
    -- Add widgets to the wibox
    s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                --mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            {
                s.textclock,
                widget = wibox.container.place,
                valign = "center",
                halign = "center",
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                --power, 
                --pulse,
                s.systray,
                {
                    {
                        orientation = "vertical",
                        span_ratio = 0.7,
                        widget = wibox.widget.separator,
                    },
                    strategy = "max",
                    width = 10,
                    widget = wibox.container.constraint,
                },
                {
                    s.cpuwidget,
                    left = 0,
                    right = 0,
                    widget = wibox.container.margin,
                },

                {
                    {
                        orientation = "vertical",
                        span_ratio = 0.7,
                        widget = wibox.widget.separator,
                    },
                    strategy = "max",
                    width = 10,
                    widget = wibox.container.constraint,
                },
                {
                    s.memwidget,
                    left = 0,
                    right = 0,
                    widget = wibox.container.margin,
                },
                {
                    {
                        orientation = "vertical",
                        span_ratio = 0.7,
                        widget = wibox.widget.separator,
                    },
                    strategy = "max",
                    width = 10,
                    widget = wibox.container.constraint,
                },
                {
                    s.mylayoutbox,
                    left = 0,
                    right = 5,
                    widget = wibox.container.margin,
                }
            },
    }
end
