---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Lucas de Vries <lucas@glacicle.com>
---------------------------------------------------

-- {{{ Grab environment
local newtimer        = require("lain.helpers").newtimer
local wibox           = require("wibox")
local io = { popen = io.popen }
local string = { match = string.match }
local setmetatable = setmetatable
-- }}}


local usbmount = {}

-- {{{ Date widget type
local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    usbmount.widget = wibox.widget.textbox('')

    function usbmount.update()
        local df = io.popen("LC_ALL=C mount")

        usbmount_now = {}
        usbmount_now.n = 0

        for l in df:lines() do
            mpoint = l:match("^[%w/-_.]+ on /media/usb([%w]+)")
            if mpoint ~= nil then
                usbmount_now.n = usbmount_now.n + 1
            end
        end
        df:close()
        widget = usbmount.widget
        settings()
    end
    newtimer("usbmount", timeout, usbmount.update)
    return setmetatable(usbmount, { __index = usbmount.widget })
end
-- }}}

return setmetatable(usbmount, { __call = function(_, ...) return worker(...) end })
