--[[

     arrow lain wibar

     Licensed under GNU General Public License v2
      * (c) 2018, Kirill Bugaev

--]]

local wrequire     = require("lainmod.helpers").wrequire
local setmetatable = setmetatable

local app = { _NAME = "wibars.app" } 

return setmetatable(app, { __index = wrequire })

