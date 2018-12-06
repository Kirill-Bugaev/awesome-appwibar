local awful		= require("awful")
local wibox		= require("wibox")
local base16		= require("base16")

local helpers		= require("lainmod.helpers")
local wibars		= require("wibars")
local widgetlist	= wibars.app.widgetlist

local function factory(args)
    local args      		= args 			or {}
    local position   		= args.position		or ""
    position = string.lower(position)
    if position ~= "left" and position ~= "right" and position ~= "top" and position ~= "bottom" then
	position = "left"
    end
    local visible   		= args.visible 		or true
    local width   		= args.width 		or 16
    local scr 			= args.screen		or awful.screen.focused() 
    local cs			= args.cs 		or base16.solarized_dark
    local separator_width 	= args.separator_width	or 3
    local transparency 		= args.transparency
    if transparency == nil then
	transparency = false
    end
    local hide			= args.hide
    if hide == nil then
	hide = false
    end
    local hidewidth		= args.hidewidth	or 3

    local iconsel_color 	= cs.palette.barbg_blue
    local iconrun_color 	= cs.palette.barbg_orange

    local sgeo = scr.geometry

    -- separator between widgets positioning
    local separator_position = ""
    if position == "left" or position == "right" then
	separator_position = "bottom"
    else
	separator_position = "right"
    end

    -- make widget list
    widgets = widgetlist({
	separator_position = separator_position,
	separator_width = separator_width,
	iconsel_color = iconsel_color,
	iconrun_color = iconrun_color
    })

    -- calculate wibar size
    local initial_dockheight = 0
    local initial_dockwidth = 0
    local dockheight = 0
    local dockwidth = 0
    if position == "left" or position == "right" then
	dockheight = #widgets * (width + separator_width) - separator_width
	dockwidth = width
	initial_dockheight = dockheight
	if hide then
	    initial_dockwidth = hidewidth
	else
	    initial_dockwidth = dockwidth
        end
    else
	dockheight =  width
	dockwidth = #widgets * (width + separator_width) - separator_width
	initial_dockwidth = dockwidth
	if hide then
	    initial_dockheight = hidewidth
	else
	    initial_dockheight = dockheight
        end

    end

    -- make wibar positioning
    -- named positioning
    local wibar_position = ""
    if hide then
	wibar_position = nil	-- will pose wibar by coordinates
    else
	wibar_position = position
    end
    -- coordinate positioning
    local initial_x = 0
    local initila_y = 0
    if position == "left" or position == "right" then
	initial_y = sgeo.height/2 - dockheight/2
	if hide then
	    if position == "left" then
		initial_x = 0
	    else
		initial_x = sgeo.width - hidewidth
	    end
	else
	    initial_x = nil	-- will pose wibar by position name
	end
    else
	initial_x = sgeo.width/2 - dockwidth/2
	if hide then
	    if position == "top" then
		initial_y = 0
	    else
		initial_y = sgeo.height - hidewidth
	    end
	else
	    initial_y = nil	-- will pose wibar by position name
	end
    end

    -- set wibar transparency
    local barbg = ""
    if transparency then
	barbg = "alpha"
    else
	barbg = cs.palette.barbg 
    end

    -- choose wibar maker
    local wibar_maker = function () end
    if hide then
	wibar_maker = wibox
    else
	wibar_maker = awful.wibar
    end

    -- make wibar
    local wibar = wibar_maker({
	position	= wibar_position,
	width		= initial_dockwidth,
	height		= initial_dockheight,
	visible 	= visible,
	screen 		= scr,
	bg 		= barbg,
	fg 		= cs.palette.barfg,
	x 		= initial_x,
	y		= initial_y,
	ontop		= true,
	type		= "dock"
    })

    -- make plain widget table
    local plain_wt = {}
    for _,v in pairs(widgets) do
	table.insert(plain_wt, v.widget)
	table.insert(plain_wt, v.spacer)
    end

    -- make single widget from plain widget table
    local align = function () end
    if position == "left" or position == "right" then
	align = wibox.layout.align.vertical
    else
	align = wibox.layout.align.horizontal
    end
    local single = helpers.make_single_widget(plain_wt, align)
    if hide then single.visible = false end

    -- add single widget to wibar
    wibar:setup {
	layout = align,
	single
    }

    -- hide wibar signal
    wibar:connect_signal("mouse::leave", function()
	if hide then
	    if position == "left" or position ==  "right" then
		wibar.width = hidewidth
		if position == "right" then
		   wibar.x = sgeo.width - hidewidth
		end
	    else
		wibar.height = hidewidth
		if position == "bottom" then
		   wibar.y = sgeo.height - hidewidth
		end
	    end
	    single.visible = false
	end
    end)
    -- show wibar signal
    wibar:connect_signal("mouse::enter", function()
	if hide then
	    if position == "left" or position == "right" then
		wibar.width = dockwidth
		if position == "right" then
		   wibar.x = sgeo.width - dockwidth
		end
	    else
		wibar.height = dockheight
		if position == "bottom" then
		   wibar.y = sgeo.height - dockheight
		end
	    end
	    single.visible = true
	end
    end)

    return wibar
end

return factory
