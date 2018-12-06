--[[
	List of application icons which showed on wibar
]]--

local confdir = (debug.getinfo(1,"S").source:sub(2)):match("(.*/)")
local icondir = confdir .. "icons/apps/"

local iconlist = { }
iconlist.taskman                         = icondir .. "system-monitor.png"
iconlist.term                            = icondir .. "terminal.png"
iconlist.mc                              = icondir .. "mc.png"
iconlist.Thunar                          = icondir .. "Thunar.png"
iconlist.firefox                         = icondir .. "firefox.png"
iconlist.chromium                        = icondir .. "chromium.png"
iconlist.qutebrowser                     = icondir .. "qutebrowser.png"
iconlist.viber                           = icondir .. "viber.png"
iconlist.deluge                          = icondir .. "deluge.png"
iconlist.vim                             = icondir .. "vim.png"
iconlist.notes                           = icondir .. "notes.png"
iconlist.gimp                            = icondir .. "gimp.png"
iconlist.screenshot                      = icondir .. "screenshot.png"
iconlist.calc                            = icondir .. "calc.png"
iconlist.zbstudio                        = icondir .. "zbstudio.png"
iconlist.dfeet                           = icondir .. "dfeet.png"

local function factory ()
    return iconlist
end

return factory()
