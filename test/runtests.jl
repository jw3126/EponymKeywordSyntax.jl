using Test
using EponymKeywordSyntax
const E = EponymKeywordSyntax

@testset "@eponym" begin
    a = 1; b = 2
    @test (A=:A, b=b) == @eponym((;A=:A, b))
    @test (a=a, b=b) == @eponym((;a, b))
    @test (b=b, a=a) == @eponym((;b, a))
    kw = (c=3, d=4)
    @test (;a=a, kw...) == @eponym((;a, kw...))
    
    f(args...; kw...) = (args=args, kw=kw)
    
    @test f(1,2) == @eponym f(1,2)
    @test f(1,2; a=a, b=b) == @eponym f(1,2;a,b)
    @test f(1,2; a=a, b=b) == @eponym f(1,2;a,b=b)
    @test f(1,2; a=b, b=b)  == @eponym f(1,2;a=b,b)
    kw = (c=3, d=4)
    @test f(;kw...) == @eponym f(;kw...)
    @test f(;a=a, hello="world", kw...) == @eponym f(;a, hello="world", kw...)
    
    @test_throws ArgumentError E.eponymmacro(:((a)))
    @test_throws ArgumentError E.eponymmacro(:((a=1; b)))
end
