# awesome-appwibar
Application wibar for Awesome WM

## Introduction

This wibar is an extension for Awesome WM. It allows you to launch application by mouse click. See [screenshots][] section below for a demonstration of wibar capabilities.

## Screenshots

![Screenshot of bottom position](https://github.com/Kirill-Bugaev/awesome-appwibar/blob/master/screenshots/appwibar_screenshot.png)
![Screenshot of left position](https://github.com/Kirill-Bugaev/awesome-appwibar/blob/master/screenshots/appwibar_screenshot2.png)

## Installation

*awesome-arrowlain-wibar requires my [awesome-lainmod][] lua library and [awesome-base16][] color schemes suite which are separately distributed. You need to install them first.*

Clone current repository to temporary directory with `git clone https://github.com/Kirill-Bugaev/awesome-appwibar.git`. Copy `wibars` directories from `awesome-appwibar` directory to your Awesome WM configuration directory (`~/.config/awesome` by default).

## Configuration

### Adding wibar to Awesome WM screens

1. Open your Awesome WM lua configuration file (`~/.config/awesome/rc.lua` by default) in text editor.

2. Include required modules by adding the following strings to the beginning of configuration file:

```lua
-- My color schemes
local base16 = require("base16")
-- My wibars
local wibars = require("wibars")
local appwibar	= wibars.app
...
```

3. Find `awful.screen.connect_for_each_screen` function call and add code which will create wibar for each Awesome screen to the end of function initialized in parameters. It should look something like this:

```lua
awful.screen.connect_for_each_screen(function(s)
...
-- {{{ Code that you should add
    s.myappwibar = appwibar.wibar({
	position	= "bottom",
	visible		= true,
	width		= 48,
	scr		= s,
	cs		= base16.solarized_dark,
	separator_width	= 3,
	transparency	= true,
	hide		= false,
	hidewidth	= 3
    })
-- }}}
end)
```

4. Restart Awesome.

### Configuring wibar

You can customize wibar creating code above to configure wibar appearance. Just change lua table item values proper way in `appwibar.wibar` function call. If some value is omitted then default will be used. Description list of available options is here:

*  `position` (`left`, `right`, `top` or `bottom`, default is `left`) sets position of wibar on screen.
*  `visible` (`true` or `false`, default is `true`) sets wibar visibility on Awesome screens.
*  `width` (`*positive_number*`, default is `16`) sets wibar width.
*  `scr` (`*awesome_screen*`, default is `awful.screen.focused()`) sets Awesome screen on which wibar will shown. If you create wibar for each screen in `awful.screen.connect_for_each_screen` function call then set this value equal to screen variable used in argument function (`s` above).
*  `cs` (`base16.*color_scheme_name*`, default is `base16.solarized_dark`) sets color scheme for wibar. 5 color schemes are available out of box: default light and dark, solarized light and dark, nord. You can add your own color scheme or import existing from [base16][] suite.
*  `separator_width` (`*positive_number*`, default is `3`) sets free space separator between application icons width.
*  `transparency` (`true` or `false`, default is `false`) sets wibar transparency. Pseudo-transparency is used.
*  `hide` (`true` or `false`, default is `false`) sets wibar autohide.
*  `hidewidth` (`*positive_number*`, default is `3`) sets wibar width when it is hided.

### Adding applications

To add application launcher to wibar you need first of all add application icon. You can find some icons in `/usr/share/icons` directory on your system. To add icon to wibar I recommend to copy icon file to `~/.config/awesome/wibars/app/icons/apps` directory (if your Awesome config directory is `~/.config/awesome` of course). Further I assume that you take my advice. You should add string is containing application name and icon file name to `iconlist.lua` configuration file (`~/.config/awesome/wibars/app/iconlist.lau` by default) after `iconlist` variable is defined:

```lua
local iconlist = { }
...
-- {{{ String you should add
iconlist.*your_application_name* = icondir .. "*your_icon_file_name*"
-- }}}
...

``` 

Wibar uses Awesome widgets to make launchers. So you should define widget variable (any valid name) for your application into `widgetlist.lua` configuration file (`~/.config/awesome/wibars/app/widgetlist.lua` by default) in `make_widgetlist()` function after `widgetlist` and `minor_args` variables are defined. Pay attention that `minor_args.separator_width = 0` string in this file sets zero separator size for last widget. It must precede only last widget variable definition. I highly recommend define widget variables in sequence that they will shown on wibar.

```lua
local function make_widgetlist (args)
    local widgetlist = {}
    local minor_args = args
...
    -- {{{ Code you should add
    local *your_application_widget_variable_name* = makewidget(
	{
	    icon = iconlist.*your_application_name*,
	    app = "*command_line_to_launch_application*"
	},
	minor_args
    )
    -- }}}
...

```

You should add defined widget variable to `widgetlist` table in the same configuration file in the same function. Notice, that sequence in which icons will shown on wibar is the same that they are placed in this table.
```lua
widgetlist = {
...
    *your_application_widget_variable_name*,
...
    }
```

### Removing applications

To remove application launcher from wibar comment or remove appropriate string into `widgetlist.lua` configuration file (`~/.config/awesome/wibars/app/widgetlist.lua` by default) in `make_widgetlist()` function in `widgetlist` table. Also you can remove defined widget variable in `make_widgetlist()` function, but it is not necessary.
```lua
widgetlist = {
...
--  *application_widget_variable*,
...
```

If you have any other issues and you can't find the answer in description above, please write me on kirill.bugaev87@gmail.com.

[screenshots]: #Screenshots
[awesome-lainmod]: https://github.com/Kirill-Bugaev/awesome-lainmod
[awesome-base16]: https://github.com/Kirill-Bugaev/awesome-base16
