---@diagnostic disable: undefined-global

local tex = require "snippets.utils.texConditions"

return {
    s({ trig = "arg", snippetType = "autosnippet", wordTrig = false }, t "\\arg", { condition = tex.in_math }),
    s({ trig = "Arg", snippetType = "autosnippet", wordTrig = false }, t "\\Arg", { condition = tex.in_math }),
    s({ trig = "lap", snippetType = "autosnippet", wordTrig = false }, t "\\laplace", { condition = tex.in_math }),
    s({ trig = "four", snippetType = "autosnippet", wordTrig = false }, t "\\fourier", { condition = tex.in_math }),
    s({ trig = "conj", snippetType = "autosnippet", wordTrig = false }, fmta("\\conj{<>}", i(1)), { condition = tex.in_math }),
}
