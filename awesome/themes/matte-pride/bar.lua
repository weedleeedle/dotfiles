local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

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

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.systray = wibox.widget.systray()
    s.textclock = wibox.widget.textclock()


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s,width = "95%", height= dpi(25),
        shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,10) end
    })

    -- Recolor title bar anytime we change tags
    tag.connect_signal("property::selected", function(t)
        -- t.screen == s allows us to limit the color change to the screen the
        -- tag is on
        if t.selected and t.screen == s then
            s.mywibox.bg = beautiful.highlight_colors[t.index].bg_normal
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
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --power, 
            --pulse,
            s.systray,
            s.textclock,
            wibox.container.margin(s.mylayoutbox,0,10,0,0),
        },
    }
end
