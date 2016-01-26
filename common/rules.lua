local awful     = require("awful")
local lain     = require("lain")
local layouts     = require("common.layouts")
local beautiful     = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },

    { rule = { class = "URxvt" },
          properties = { opacity = 0.99 } },

    { rule = { class = "Firefox" },
          properties = { tag = tags[1][3] } },

    { rule = { class = "Skype" },
          properties = { tag = tags[1][6] } },

    { rule = { class = "URxvt", instance = "Mail" },
          properties = { tag = tags[1][2] } },

    { rule = { class = "URxvt", instance = "News" },
          properties = { tag = tags[1][4] } },

    { rule = { class = "MPlayer" },
          properties = { floating = true } },
}
-- }}}
