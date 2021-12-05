# Note: This solution is sloow
# Check day5.jl for better solution

struct Point
    x::Int
    y::Int
end
Point((x, y)) = Point(x, y)
Base.show(io::IO, p::Point) = print(io, "(x=$(p.x), y=$(p.y))")

function points(p1::Point, p2::Point)::Vector{Point}
    x1, x2 = p1.x, p2.x
    y1, y2 = p1.y, p2.y

    m = (y2 - y1) / (x2 - x1)
    if m == 0 
        xs = x1 < x2 ? (x1:x2) : (x1:-1:x2)
        points = zip(xs, fill(y1, length(xs)))
        return Point.(points)
    elseif m == Inf || m == -Inf
        ys = y1 < y2 ? (y1:y2) : (y1:-1:y2)
        points = zip(fill(x1, length(ys)), ys)
        return Point.(points)
    elseif m == 1 || m == -1
        xs = x1 < x2 ? (x1:x2) : (x1:-1:x2)
        ys = y1 < y2 ? (y1:y2) : (y1:-1:y2)
        points = zip(xs, ys)
        return Point.(points)
    end
end

# Data
hseg_points = Point[]
for line in readlines(joinpath(@__DIR__, "input.txt"))
    p1, p2 = split(line, " -> ")
    x1, y1 = parse.(Int, split(p1, ","))
    x2, y2 = parse.(Int, split(p2, ","))
    if x1 == x2 || y1 == y2
        append!(hseg_points, points(Point(x1, y1), Point(x2, y2)))
    end
end

## Part 1 -------------------------------------------------
function overlap(pts)
    x = 0
    for p in unique(pts)
        count(==(p), pts) > 1 && (x += 1)
    end
    return x
end

# Solution: 7644
overlap(hseg_points)

## Part 2 -------------------------------------------------
seg_points = Point[]
for line in readlines(joinpath(@__DIR__, "input.txt"))
    p1, p2 = split(line, " -> ")
    x1, y1 = parse.(Int, split(p1, ","))
    x2, y2 = parse.(Int, split(p2, ","))
    append!(seg_points, points(Point(x1, y1), Point(x2, y2)))
end

# Solution: 18627
overlap(seg_points)
