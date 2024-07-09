using Printf
using BenchmarkTools

v = [1, 2, 3]
typeof(v)

#=
Julia is typed. You can see that the type of v is an Array{Int64,1}.
In julia, there is no differnence between a list and an array; we don't need numpy with it's C-backend to speed things up; Julia is fast on its own.

To showcase some of julia's syntax differences, we are going to implement an estimate of π with
π = 4 * (1 - 1/3 + 1/5 - 1/7 + 1/9 - 1/11 + ...)
=#

function estimate_pi(n)
    s = 1.0
    for i in 1:n
        s += (isodd(i) ? -1 : 1) / (2i + 1)
    end
    4s
end

n = 100_000_000
println("Benchmark estimate_pi, using n = $n")
@benchmark estimate_pi(n)

p = estimate_pi(100_000_000)
println("π ≈ $p")
println("Error is $(p - π)")

@printf("""Pretty similar, but notice the differences:
| Julia               | Python                      |
|---------------------|-----------------------------|
| function            | def                         |
| for i in X          | for i in X:                 |
| ... end             | ...                         |
| 1:n                 | range(1, n+1)               |
| cond ? a : b        | a if cond else b            |
| 2i + 1              | 2 * i + 1                   |
| 4s                  | return 4 * s                |
| println(a, b)       | print(a, b, sep="")         |
| print(a, b)         | print(a, b, sep="", end="") |
| %.4f              |  run bench.py               |
| %.4e          |  run bench.py               |""", p, p - π)

#=
There are acutally multiple ways to define a function in Julia. The `function` keyword resembles pythons `def`, but there is also a shorthand for one-liners.
The first time you see this, it might seem like you are defining a variable, but the `=` is actually an assignment operator.
=#
f(x) = x^2
f(10)

#=
note how we can use unicode symbols like μ to define an average function
note how we can specify that this function works for a vector of Reals only with Vector{<:Real}
more info on the typing system is here: https://docs.julialang.org/en/v1/manual/types/
=#
μ(x:: Vector{<:Real}) = sum(x) / length(x)
v = [1.0, 2.0, 3.0]
μ(v)

# It is possible to create anonymous function with `->`. This can be compared to the `lambda` keyword in python.
f = x -> x^2
f(4)

#= a classic example of a function that takes other functions as an argument is the `map` method,
    which applies a function to each value of an array
=#
map(round, [1.2, 2.5, 3.7])

map(x -> x^2, [1.1, 2.5, 3.7])

#=
In python, both numpy and torch will use broadcasting. However, this happens implicitly. Eg, if you do:

    >>> import numpy as np
    >>> x = np.array([1, 2, 3])
    >>> x + 1
    array([2, 3, 4])

This will add 1 to each element of x. Under the hood, the +1 is actually handled like [1, 1, 1]. The same happens with multiplication, division, etc.

There are some rules in python that numpy will follow to broadcast the arrays. The downside of this implicit behavior is that it might go unnoticed, which is why in Julia broadcasting is explicit.
Notice the dot before the `+` to broadcast the operation over the vector.
=#

x = [1, 2, 3]
x .+ 1


#=
There are multiple plotting libraries. The simplest one is Plots, but
there are also libraries that are much more sofiticated, and support dashboarding, gifs, 3D plots etc.
=#

using Plots
x = range(-5π, 5π, length=100)
plot(x, sin.(x) ./ x, title="sin(x) / x", grid=true)

# There is something similar to list comprehensions in julia as there is in python.
b = [i^3 for i in -2π:0.5:2π]
scatter(b)