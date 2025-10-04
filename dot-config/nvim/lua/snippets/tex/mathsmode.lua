---@diagnostic disable: undefined-global

local tex = require "snippets.utils.texConditions"

return {
    s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, t "\\pi", { condition = tex.in_math }),
    s({ trig = "\\gamma", wordTrig = false }, t "\\gamma", { condition = tex.in_math }),
    s({ trig = "\\lambda", wordTrig = false }, t "\\lambda", { condition = tex.in_math }),
    s({ trig = "\\alpha", wordTrig = false }, t "\\alpha", { condition = tex.in_math }),
    s({ trig = "\\beta", wordTrig = false }, t "\\beta", { condition = tex.in_math }),
    s({ trig = "\\sigma", wordTrig = false }, t "\\sigma", { condition = tex.in_math }),
    s({ trig = "\\theta", wordTrig = false }, t "\\theta", { condition = tex.in_math }),
    s({ trig = "\\subset", wordTrig = false }, t "\\subset", { condition = tex.in_math }),
    s({ trig = "\\not", wordTrig = false }, t "\\not", { condition = tex.in_math }),
    s({ trig = "\\in", wordTrig = false }, t "\\in", { condition = tex.in_math }),
    s({ trig = "set", wordTrig = false }, fmta([[\{ <> \}]], { i(0) }), { condition = tex.in_math }),
    s({ trig = "del", snippetType = "autosnippet", wordTrig = false }, t "\\partial", { condition = tex.in_math }),
    s({ trig = "dint", snippetType = "autosnippet" }, fmta([[\int\limits_<>^<> <> \, d<>]], { i(1), i(2), i(3), i(0) }), { condition = tex.in_math }),
    s({ trig = "sumlu", snippetType = "autosnippet" }, fmta([[\sum_{<>}^<> <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "lim", snippetType = "autosnippet" }, fmta([[\lim_{<> \to <>} <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "prod", snippetType = "autosnippet" }, fmta([[\prod_{<>}^<> <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "ff", snippetType = "autosnippet", wordTrig = false }, fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = tex.in_math }),
    s("left", fmta("\\left<> <> \\right<>", { i(1), i(3), i(2) }), { condition = tex.in_math }),
    s({ trig = "mbb", snippetType = "autosnippet", wordTrig = false }, t "\\mathbb", { condition = tex.in_math }),
    s({ trig = "mcal", snippetType = "autosnippet", wordTrig = false }, t "\\mathcal", { condition = tex.in_math }),
    s({ trig = "mscr", snippetType = "autosnippet", wordTrig = false }, t "\\mathscr", { condition = tex.in_math }),
    s({ trig = "hat", snippetType = "autosnippet", wordTrig = false }, fmta("\\hat{<>}<>", { i(1), i(0) }), { condition = tex.in_math }),
    s({ trig = "inf", snippetType = "autosnippet" }, t "\\infty", { condition = tex.in_math }),
    s({ trig = "srt", snippetType = "autosnippet" }, fmta("\\sqrt{<>}", { i(1) }), { condition = tex.in_math }),
    s(
        { trig = "(%a)ss", snippetType = "autosnippet", desc = "subscript", regTrig = true, wordTrig = false },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_math }
    ),
    -- s(
    --     { trig = "(%a)(%d)", snippetType = "autosnippet", desc = "subscript", regTrig = true, wordTrig = false },
    --     fmta("<>_<>", {
    --         f(function(_, snip)
    --             return snip.captures[1]
    --         end),
    --         f(function(_, snip)
    --             return snip.captures[2]
    --         end),
    --     }),
    --     { condition = tex.in_math }
    -- ),
    s(
        { trig = "(%w)pp", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_math }
    ),
    s({ trig = "sq", snippetType = "autosnippet", wordTrig = false }, t "^2", { condition = tex.in_math }),
    s({ trig = "cubed", snippetType = "autosnippet", wordTrig = false }, t "^3", { condition = tex.in_math() }),
}
