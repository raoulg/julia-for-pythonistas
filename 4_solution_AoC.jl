data = readlines(open("data/day2-test.txt"))
blue = r"\d+(?= blue)"
red = r"\d+(?= red)"
green = r"\d+(?= green)"

#=
1. A parser function
create a parser function, that takes a regex match as input and parses it into an Int64
=#
parseToInt(m) = isnothing(m) ? 0 : parse(Int64, m.match)


#=
2. A Game struct
create a struct named Game with fields red, green, blue that are all integers
    Functions I used:
        - struct (see ?struct)
=#
struct Game
    red :: Int
    green :: Int
    blue :: Int
end

#=
3. Constructor
create a constructor for the Game struct, that takes a full datastring as input and returns a Game object
    Functions I used:
        - match (see ?match)
        - my own parseToInt function
=#
function Game(sample::T) where {T <: AbstractString}
    Game(
        parseToInt(match(red, sample)),
        parseToInt(match(green, sample)),
        parseToInt(match(blue, sample))
    )
end

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
function Base.:<=(g1::Game, g2::Game)
    g1.red <= g2.red && g1.green <= g2.green && g1.blue <= g2.blue
end

#=
5. check all options
write a function to check which games are possible.
    The function should take as input:
        - data, in the form of a Vector{String}
        - a Game object, that defines the maximum values for red, green and blue

    with a list comprehension and the overloaden <= operator, you can check for all games on a single line.
=#
function check_possibility(data::Vector{String}, max:: Game)
    possible = 0
    for line in data
        id, games = split(line, ":")
        id = parse(Int, match(r"\d+", id).match)
        check = all([Game(s) <= max for s in split(games, ";")])
        if check
            possible += id
        end
    end
    possible
end
check_possibility(data, Game(12, 13, 14 ))

data = readlines(open("data/day2.txt"))
check_possibility(data, Game(12, 13, 14 ))