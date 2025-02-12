---@diagnostic disable: undefined-global

return {
    s(
        { trig = "align", desc = "An align environment" },
        fmt(
            [[
    \begin{align*}
        <>
    \end{align*}
    ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s(
        { trig = "template", desc = "A basic template for a LaTeX project" },
        fmt(
            [[
                \documentclass[a4paper]{article}
                \usepackage[nynorsk]{babel}
                \usepackage[T1]{fontenc}
                \usepackage{graphicx}
                \usepackage{amsmath}
                \usepackage{amsfonts}
                \usepackage{microtype}
                \usepackage[utf8]{inputenc}
                
                \usepackage{hyperref}
                \hypersetup{
                colorlinks,
                citecolor=black,
                filecolor=black,
                linkcolor=black,
                urlcolor=black
                }
                
                \begin{document}
                
                <>
                
                \end{document}
                ]],
            { i(0) },
            { delimiters = "<>" }
        )
    ),
    s(
        { trig = "begin", desc = "A general display environment" },
        fmt(
            [[
        \begin{<>}
            <>
        \end{<>}
        ]],
            { i(1), i(2), rep(1) },
            { delimiters = "<>" }
        )
    ),
    s(
        { trig = "dm", desc = "A display math environment" },
        fmt(
            [[
        \[
            <>
        \]<>
        ]],
            { i(1), i(0) },
            { delimiters = "<>" }
        )
    ),
    s(
        { trig = "figure", desc = "A basic figure" },
        fmta(
            [[
            \begin{figure}<>
                \centering
                \includegraphics[width=<>\linewidth]{figures/<>}
                \caption{<>}
                \label{<>}
            \end{figure}
            ]],
            { i(5), i(4, "0.95"), i(1), i(2), i(3) }
        )
    ),
}
