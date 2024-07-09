# Define the struct for a Circle
struct Circle
    radius::Float64
end
circle = Circle(5.0)

# Define the struct for a Rectangle
struct Rectangle
    width::Float64
    height::Float64
    Rectangle(side::Float64) = new(side, side)
end

rectangle = Rectangle(4.0, 6.0)
square = Rectangle(3.0)

# Define the struct for a Triangle
struct Triangle
    base::Float64
    height::Float64
end
Triangle(side::Float64) = Triangle(side, side)
Triangle(side::String) = Triangle(parse(Float64, side))

triangle = Triangle(3.0, 4.0)
equilateral = Triangle(3.0)
equilateral_string = Triangle("8")

# Define the area function for Circle
function area(shape::Circle)
    return π * shape.radius^2
end

# Define the area function for Rectangle
function area(shape::Rectangle)
    return shape.width * shape.height
end

# Define the area function for Triangle
function area(shape::Triangle)
    return 0.5 * shape.base * shape.height
end
# Create instances of each shape

# Calculate and print the areas
println("Area of Circle: ", area(circle))
println("Area of Rectangle: ", area(rectangle))
println("Area of Square: ", area(square))
println("Area of Triangle: ", area(triangle))
println("Area of Equilateral Triangle: ", area(equilateral))


