---@diagnostic disable: undefined-global

local tex = require "snippets.utils.texConditions"

return {
    s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, t "\\pi", { condition = tex.in_math }),
    s({ trig = "dl", snippetType = "autosnippet", wordTrig = false }, t "\\delta", { condition = tex.in_math }),
    s({ trig = "gamma", snippetType = "autosnippet", wordTrig = false }, t "\\gamma", { condition = tex.in_math }),
    s({ trig = "lambda", snippetType = "autosnippet", wordTrig = false }, t "\\lambda", { condition = tex.in_math }),
    s({ trig = "alpha", snippetType = "autosnippet", wordTrig = false }, t "\\alpha", { condition = tex.in_math }),
    s({ trig = "beta", snippetType = "autosnippet", wordTrig = false }, t "\\beta", { condition = tex.in_math }),
    s({ trig = "mu", snippetType = "autosnippet", wordTrig = false }, t "\\mu", { condition = tex.in_math }),
    s({ trig = "sigma", snippetType = "autosnippet", wordTrig = false }, t "\\sigma", { condition = tex.in_math }),
    s({ trig = "theta", snippetType = "autosnippet", wordTrig = false }, t "\\theta", { condition = tex.in_math }),
    s({ trig = "del", snippetType = "autosnippet", wordTrig = false }, t "\\partial", { condition = tex.in_math }),
    s({ trig = "ins", snippetType = "autosnippet", wordTrig = false }, t "\\in", { condition = tex.in_math }),
    s({ trig = "dint", snippetType = "autosnippet" }, fmta([[\int\limits_<>^<> <> \, d<>]], { i(1), i(2), i(3), i(0) }), { condition = tex.in_math }),
    s({ trig = "sum", snippetType = "autosnippet" }, fmta([[\sum_{<>}^<> <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "lim", snippetType = "autosnippet" }, fmta([[\lim_{<> \to <>} <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "prod", snippetType = "autosnippet" }, fmta([[\prod_{<>}^<> <>]], { i(1), i(2), i(0) }), { condition = tex.in_math }),
    s({ trig = "ff", snippetType = "autosnippet", wordTrig = false }, fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = tex.in_math }),
    s({ trig = "fox", snippetType = "autosnippet" }, t "f(x)", { condition = tex.in_math }),
    s({ trig = "sin", snippetType = "autosnippet", wordTrig = false }, t "\\sin", { condition = tex.in_math }),
    s({ trig = "cos", snippetType = "autosnippet", wordTrig = false }, t "\\cos", { condition = tex.in_math }),
    s("left", fmta("\\left<> <> \\right<>", { i(1), i(3), i(2) }), { condition = tex.in_math }),
    s({ trig = "mbb", snippetType = "autosnippet", wordTrig = false }, fmta("\\mathbb{<>}<>", { i(1), i(0) }), { condition = tex.in_math }),
    s({ trig = "hat", snippetType = "autosnippet", wordTrig = false }, fmta("\\hat{<>}<>", { i(1), i(0) }), { condition = tex.in_math }),
    s({ trig = "bar", snippetType = "autosnippet", wordTrig = false }, fmta("\\overline{<>}<>", { i(1), i(0) }), { condition = tex.in_math }),
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
        { trig = "(%a)pp", snippetType = "autosnippet", regTrig = true, wordTrig = false },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_math }
    ),
    s({ trig = "sq", snippetType = "autosnippet", wordTrig = false }, t "^2", { condition = tex.in_math }),
}
