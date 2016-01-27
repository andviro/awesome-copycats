local awful     = require("awful")
local layouts = require("common/layouts")
tags = {
    names = { "1", "2", "3", "4", "5", "6" },
    layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] },
    rules = {
        nil,
        nil,
        --{class="Chromium-browser"},
        --{class="Firefox"},
        nil
        nil,
        nil,
        nil,
    },
    autorun = {nil, nil, nil, nil, nil, nil}
}

function autorun(tag, command, rule)
    if tag.selected then
        local found = false
        for _, c in pairs(tag:clients()) do
            if awful.rules.match(c, rule) then
                found = true
                break
            end
        end
        if not found then
            awful.util.spawn(command)
        end
    end
end

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
    for k, tag in pairs(awful.tag.gettags(s)) do
        tag:connect_signal("property::selected", function(t)
            autorun(t, tags.autorun[k], tags.rules[k])
        end)
    end
end
