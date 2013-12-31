local awful     = require("awful")
-- Create a laucher widget and a main menu
myexitmenu = {
   { "Restart", awesome.restart },
   { "Quit", awesome.quit },
   { "Suspend", "sudo pm-hibernate" }
}

require('freedesktop')
-- require("debian.menu")

freedesktop.utils.terminal   = env.term -- defined in rc.lua, otherwise define it here (default: "xterm")
freedesktop.utils.icon_theme = 'gnome'  -- choose your favourite from /usr/share/icons/ (default: nil)

menu_items = freedesktop.menu.new()

mymainmenu = awful.menu({ items =
  {
    { "MC", env.mc },
    { "Terminal", env.term },
    { "Unmount", "/home/andrew/devel/scripts/umount/eject_usb" },
    { "Apps", menu_items },
    { "Exit", myexitmenu}
  }
})


