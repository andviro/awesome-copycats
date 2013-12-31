---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Lucas de Vries <lucas@glacicle.com>
---------------------------------------------------

-- {{{ Grab environment
local io = { popen = io.popen }
local string = { match = string.match }
local setmetatable = setmetatable
-- }}}


-- Date: provides access to os.date with optional custom formatting
module("usbmount")


-- {{{ Date widget type
local function worker(format)
  local df = io.popen("LC_ALL=C mount")
  local n = 0
  for l in df:lines() do
    mpoint = l:match("^[%w/-_.]+ on /media/([%w]+)")
    if mpoint ~= nil then
      n = n + 1
    end
  end
  df:close()
  return {n}
end
-- }}}

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
