------------------------------------------
-- Effortless wmii-style dynamic tagging.
------------------------------------------
-- Lucas de Vries <lucas@glacicle.org>
-- Licensed under the WTFPL version 2
--   * http://sam.zoy.org/wtfpl/COPYING
-----------------------------------------
-- Cut version
-----------------------------------------

-- Grab environment
local ipairs = ipairs
local awful = require("awful")
local table = table
local capi = {
    screen = screen,
    mouse = mouse,
}

-- Eminent: Effortless wmii-style dynamic tagging
module("eminent")

-- Grab the original functions we're replacing
local deflayout = nil
local orig = {
    new = awful.tag.new,
    taglist = awful.widget.taglist.new,
    filter = awful.widget.taglist.filter.all,
}

-- Return tags with stuff on them, mark others hidden
function gettags(screen)
    local tags = {}

    for k, t in ipairs(capi.screen[screen]:tags()) do
        if t.selected or #t:clients() > 0 then
            awful.tag.setproperty(t, "hide", false)
            table.insert(tags, t)
        else
            awful.tag.setproperty(t, "hide", true)
        end
    end

    return tags
end

-- Pre-create tags
awful.tag.new = function (names, screen, layout)
    deflayout = layout and layout[1] or layout
    return orig.new(names, screen, layout)
end

-- Taglist label functions
awful.widget.taglist.filter.all = function (t, args)
    if t.selected or #t:clients() > 0 then
        return orig.filter(t, args)
    end
end

-- View tag by relative index
awful.tag.viewidx = function (i, screen)
    local screen = screen or capi.mouse.screen
    local tags = awful.tag.gettags(screen)
    local showntags = {}
    for k, t in ipairs(tags) do
        if not awful.tag.getproperty(t, "hide") and (#t:clients() > 0 or t.selected) then
            table.insert(showntags, t)
        end
    end
    local sel = awful.tag.selected(screen)
    awful.tag.viewnone(screen)
    for k, t in ipairs(showntags) do
        if t == sel then
            showntags[awful.util.cycle(#showntags, k + i)].selected = true
        end
    end
    capi.screen[screen]:emit_signal("tag::history::update")
end
