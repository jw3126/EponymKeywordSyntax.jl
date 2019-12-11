using Documenter, EponymKeywordSyntax

makedocs(;
    modules=[EponymKeywordSyntax],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/jw3126/EponymKeywordSyntax.jl/blob/{commit}{path}#L{line}",
    sitename="EponymKeywordSyntax.jl",
    authors="Jan Weidner <jw3126@gmail.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/jw3126/EponymKeywordSyntax.jl",
)
