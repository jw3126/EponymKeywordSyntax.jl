# EponymKeywordSyntax

[![Build Status](https://travis-ci.com/jw3126/EponymKeywordSyntax.jl.svg?branch=master)](https://travis-ci.com/jw3126/EponymKeywordSyntax.jl)
[![Codecov](https://codecov.io/gh/jw3126/EponymKeywordSyntax.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jw3126/EponymKeywordSyntax.jl)

# Important

On `Julia 1.5` eponym keyword syntax is [supported by the julia language directly](https://github.com/JuliaLang/julia/pull/34331). So this package should not be needed on newer julia versions.

# Usage
This package provides the `@eponym` macro, which infers the name of a keyword argument
from the name of its value. This is best explained by example:
```julia
julia> using EponymKeywordSyntax

julia> f(args...; kw...) = (args=args, kw=kw)
f (generic function with 1 method)

julia> oh_dear_this_is_long_I_dont_want_to_write_it_twice=3
3
julia> f(oh_dear_this_is_long_I_dont_want_to_write_it_twice=oh_dear_this_is_long_I_dont_want_to_write_it_twice) == @eponym f(;oh_dear_this_is_long_I_dont_want_to_write_it_twice)
true

julia> a=1; b=2;
2

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
