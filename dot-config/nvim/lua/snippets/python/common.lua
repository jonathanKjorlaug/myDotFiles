---@diagnostic disable: undefined-global

return {
    s({ trig = "multiline", desc = "A multiline comment" }, fmta('""" <> """', { i(0) })),
}
