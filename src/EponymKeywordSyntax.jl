module EponymKeywordSyntax
export @eponym

using MacroTools: @capture, splitarg, MacroTools

function resolve_kwarg(kwarg)
    key, typ, splat, val = splitarg(kwarg)
    if splat
        kwarg
    elseif val == nothing
        :($key = $key)
    else
        kwarg
    end
end

"""

    @eponym(ex)

The `@eponym` macro infers the name of a keyword argument
from the name of its value. This is best explained by example:
```jldoctest
julia> using EponymKeywordSyntax

julia> f(args...; kw...) = (args=args, kw=kw)
f (generic function with 1 method)

julia> oh_dear_this_is_long_I_dont_want_to_write_it_twice=3
3
julia> f(oh_dear_this_is_long_I_dont_want_to_write_it_twice=oh_dear_this_is_long_I_dont_want_to_write_it_twice) == @eponym f(;oh_dear_this_is_long_I_dont_want_to_write_it_twice)
true

julia> a=1; b=2;


julia> f(a=a, b=b) == @eponym f(;a,b)
true

julia> (a=a, b=b) == @eponym (;a, b)
true

julia> (a=a, b=10) == @eponym (;a, b=10)
true

julia> f(1, a=a, b=b) == @eponym f(1;a, b)
true
```
"""
macro eponym(ex)
    esc(eponymmacro(ex))
end

function eponymmacro(ex)
    ret = if @capture ex (f_(args__; kw__))
        # function call
        kw = map(resolve_kwarg, kw)
        :($(f)($(args...); $(kw...)))
    elseif @capture ex (;kw__)
        kw = map(resolve_kwarg, kw)
        # NamedTuple
        :((;$(kw...)))
    elseif Meta.isexpr(ex, :call) || Meta.isexpr(ex, :tuple)
        ex
    else
        msg = """
        Macro `@eponym` can only be applied to function calls, or `NamedTuple` calls
        that begin with `;`.
        Got: $(ex)
        """
        throw(ArgumentError(msg))
    end
end

end # module
