--[[
	Make icon and spacer widgets for application wibar
]]--

local gears	= require("gears")
local awful	= require("awful")
local wibox	= require("wibox")
local cairo	= require("lgi").cairo

local base16	= require("base16")

-- Create widget from corresponding *.png files
local function makewidget (essential_args, minor_args)
    local essential_args	= essential_args 		or {}
    local icon			= essential_args.icon 		or ""
    local app			= essential_args.app		or ""
    local minor_args		= minor_args			or {}
    local separator_position	= minor_args.separator_position	or ""
    separator_position = string.lower(separator_position)
    if separator_position ~= "right" and separator_position ~= "bottom" then
	separator_position = "bottom"
    end
    local separator_width 	= minor_args.separator_width	or 3
    local iconsel_color		= minor_args.iconsel_color or base16.solarized_dark.palette.barbg_blue
    local iconrun_color		= minor_args.iconrun_color or base16.solarized_dark.palette.barbg_orange

    -- Icon widget
    local widget = wibox.widget.imagebox(icon)
    widget.app_icon = icon
    -- Separator
    local spacer = wibox.widget.textbox()
    if separator_position == "bottom" then
	spacer.forced_height = separator_width
    else
	spacer.forced_width = separator_width
    end

    -- Make selected icon 
    local function icon_sel (source_icon, sel_color)
--	local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 16, 16)
	local img = cairo.ImageSurface.create_from_png(source_icon)
	local rect_size = math.floor(cairo.ImageSurface.get_width(img) * 0.33 + 0.5)
	local cr  = cairo.Context(img)
	cr:set_source(gears.color(sel_color))
	cr:rectangle(0, 0, rect_size, rect_size)
	cr:fill()
	return img
    end

    -- Signals
    -- for icon widget
    widget:connect_signal('mouse::enter', function ()
	widget:set_image(icon_sel(icon, iconsel_color))
    end)
    widget:connect_signal('mouse::leave', function ()
	widget:set_image(icon)
    end)
    -- for separator
    spacer:connect_signal('mouse::enter', function ()
	widget:set_image(icon_sel(icon, iconsel_color))
    end)
    spacer:connect_signal('mouse::leave', function ()
	widget:set_image(icon)
    end)

    -- Application launch on mouse click
    -- for icon widget
    widget:buttons(awful.util.table.join (
	awful.button({}, 1, function()
	    widget:set_image(icon_sel(icon, iconrun_color))
	    awful.spawn(app)
	end)
    ))
    -- for separator
    spacer:buttons(awful.util.table.join (
	awful.button({}, 1, function()
	    widget:set_image(icon_sel(icon, iconrun_color))
	    awful.spawn(app)
	end)
    ))

    return { widget = widget, spacer = spacer }
end

local function factory (essential_args, minor_args)
    return makewidget(essential_args, minor_args) 
end

return factory
