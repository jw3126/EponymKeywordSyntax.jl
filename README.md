# EponymKeywordSyntax

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jw3126.github.io/EponymKeywordSyntax.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jw3126.github.io/EponymKeywordSyntax.jl/dev)
[![Build Status](https://travis-ci.com/jw3126/EponymKeywordSyntax.jl.svg?branch=master)](https://travis-ci.com/jw3126/EponymKeywordSyntax.jl)
[![Codecov](https://codecov.io/gh/jw3126/EponymKeywordSyntax.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jw3126/EponymKeywordSyntax.jl)

# Usage
This package provides the `@eponym` macro, which infers the name of a keyword argument
from the name of its value. This is best explained by example:
```julia
julia> using EponymKeywordSyntax
julia> a=1; b=2
2
julia> f(args...; kw...) = (args=args, kw=kw)
f (generic function with 1 method)
julia> f(a=a, b=b) == @eponym f(;a,b)
true
julia> (a=a, b=b) == @eponym (;a, b)
true
julia> (a=a, b=10) == @eponym (;a, b=10)
true
julia> f(1, a=a, b=b) == @eponym f(1;a, b)
true
```

# Acknowledgements
Based on [this](https://discourse.julialang.org/t/keyword-arguments-without-a-keyword/31863/1) discussion.
