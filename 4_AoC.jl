data = readlines(open("data/day2-test.txt"))

# I created four regexes to extract the numbers from the strings
blue = r"\d+(?= blue)"
red = r"\d+(?= red)"
green = r"\d+(?= green)"
m = match(red, data[1])

#=
1. A parser function
create a parser function, that takes a regex match as input and parses it into an Int64
    Functions I used:
        - isnothing (see ?isnothing)
        - the trinary operator (cond ? yes : no)
        - the parse function (see ?parse)
=#

@assert parseToInt(m) == 4

#=
2. A Game struct
create a struct named Game with fields red, green, blue that are all integers
    Functions I used:
        - struct (see ?struct)
=#

g =  Game(1, 2, 3)
@assert g.red == 1 g.green == 2 g.blue == 3


#=
3. Constructor
create a constructor for the Game struct, that takes a full datastring as input and returns a Game object
    Functions I used:
        - match (see ?match)
        - my own parseToInt function
=#

@assert Game(data[1]) == Game(4,2,3)

#=
4. Overloading
Overload the Base.<= function to compare two Game objects
    Functions I used:
        - Base.<= (see ?Base.<=)

example:
struct Point
    x::Float64
    y::Float64
end
Base.:+(p1::Point, p2::Point) = Point(p1.x + p2.x, p1.y + p2.y)
=#


@assert Game(1, 2, 3) <= Game(4, 5, 6)
@assert !(Game(4, 5, 6) <= Game(1, 2, 3))

#=
5. check all options
write a function to check which games are possible.
    The function should take as input:
        - data, in the form of a Vector{String}
        - a Game object, that defines the maximum values for red, green and blue

    with a list comprehension and the overloaden <= operator, you can check for all games on a single line.
=#

function check_possibility(data::Vector{String}, max:: Game)
   nothing
end
@assert check_possibility(data, Game(12, 13, 14 )) == 8

data = readlines(open("data/day2.txt"))
possible_games = check_possibility(data, Game(12, 13, 14 ))
@assert possible_games == 1853