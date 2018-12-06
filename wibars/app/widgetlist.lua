--[[
	List of icon widgets which showed on wibar
]]--

local awful		= require("awful")

local wibars		= require("wibars")
local iconlist		= wibars.app.iconlist
local makewidget	= wibars.app.makewidget

local function make_widgetlist (args)
    local widgetlist = {}

    local minor_args = args
    -- terminal
    local myterm = makewidget(
	{
	    icon = iconlist.term,
--	    app = "/usr/bin/urxvtc" 
	    app = awful.util.terminal .. " -e /usr/bin/tmux"
	},
	minor_args
    )
    -- midnight commander
    local mymc = makewidget(
	{
	    icon = iconlist.mc,
	    app = awful.util.terminal .. " -e /usr/bin/mc"
	},
	minor_args
    )
    -- Thunar
    local myThunar = makewidget(
	{
	    icon = iconlist.Thunar,
	    app = "/usr/bin/thunar" 
	},
	minor_args
    )
    -- vim
    local myvim = makewidget(
	{
	    icon = iconlist.vim,
--	    app = "/usr/bin/urxvtc -e vim" 
	    app = awful.util.terminal .. " -e vim"
	},
	minor_args
    )
    -- ZeroBrane Studio
    local myzbstudio = makewidget(
	{
	    icon = iconlist.zbstudio,
	    app = "/usr/bin/bash -c /home/user1/bin/zbstudio"
	},
	minor_args
    )
    -- d-feet
    local mydfeet = makewidget(
	{
	    icon = iconlist.dfeet,
	    app = "/usr/bin/d-feet"
	},
	minor_args
    )
    -- xfce4 notes
    local mynotes = makewidget(
	{
	    icon = iconlist.notes,
	    app = "/usr/bin/bash -c /usr/bin/xfce4-notes" 
	},
	minor_args
    )
    -- galculator calc
    local mycalc = makewidget(
	{
	    icon = iconlist.calc,
	    app = "/usr/bin/galculator"
	},
	minor_args
    )
    -- firefox 
    local myfirefox = makewidget(
	{
	    icon = iconlist.firefox,
	    app = "/usr/bin/firefox" 
	},
	minor_args
    )
    -- midori 
    local mychromium = makewidget(
	{
	    icon = iconlist.chromium,
	    app = "/usr/bin/chromium" 
	},
	minor_args
    )
    -- qutebrowser 
    local myqutebrowser = makewidget(
	{
	    icon = iconlist.qutebrowser,
	    app = "/usr/bin/qutebrowser" 
	},
	minor_args
    )
    -- deluge 
    local mydeluge = makewidget(
	{
	    icon = iconlist.deluge,
	    app = "/usr/bin/deluge" 
	},
	minor_args
    )
    -- viber 
    local myviber = makewidget(
	{
	    icon = iconlist.viber,
	    app = "/usr/bin/viber" 
	},
	minor_args
    )
    -- gimp 
    local mygimp = makewidget(
	{
	    icon = iconlist.gimp,
	    app = "/usr/bin/gimp" 
	},
	minor_args
    )
    -- xfce screenshooter 
    local myscreenshot = makewidget(
	{
	    icon = iconlist.screenshot,
	    app = "/usr/bin/xfce4-screenshooter"
	},
	minor_args
    )
   -- xfce4 task manager
   minor_args.separator_width = 0	-- no separator for last widget
   local mytaskman = makewidget(
	{
	    icon = iconlist.taskman,
	    app = "/usr/bin/xfce4-taskmanager" 
	},
	minor_args
    )

    -- Widget list. Order is important.
    -- Don't make widgets in table. Use local variables,
    -- otherwise order will not correct.
    widgetlist = {
	myterm,
	mymc,
	myThunar,
	myvim,
        myzbstudio,
        mydfeet,
    	mynotes,
    	mycalc,
    	myfirefox,
    	mychromium,
    	myqutebrowser,
    	mydeluge,
    	myviber,
    	mygimp,
    	myscreenshot,
   	mytaskman
    }

    return widgetlist
end

local function factory (...)
    return make_widgetlist(...)
end

return factory
