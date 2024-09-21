---@diagnostic disable: undefined-global

local tex = require "snippets.utils.texConditions"

return {
    s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, t "\\pi", { condition = tex.in_math }),
    s(
        { trig = "dint", snippetType = "autosnippet" },
        fmt([[\int\limits_<>^<> <> \, d<>]], { i(1), i(2), i(3), i(0) }, { delimiters = "<>" }),
        { condition = tex.in_math }
    ),
    s(
        { trig = "ff", snippetType = "autosnippet", wordTrig = false },
        fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" }),
        { condition = tex.in_math }
    ),
    s({ trig = "fox", snippetType = "autosnippet" }, t "f(x)", { condition = tex.in_math }),
    s({ trig = "sin", snippetType = "autosnippet" }, t "\\sin", { condition = tex.in_math }),
    s({ trig = "cos", snippetType = "autosnippet" }, t "\\cos", { condition = tex.in_math }),
    s("left", fmt("\\left<> <> \\right<>", { i(1), i(3), i(2) }, { delimiters = "<>" }), { condition = tex.in_math }),
    s({ trig = "inf", snippetType = "autosnippet" }, t "\\infty", { condition = tex.in_math }),
    s({ trig = "srt", snippetType = "autosnippet" }, fmt("\\sqrt{<>}", { i(1) }, { delimiters = "<>" }), { condition = tex.in_math }),
}
