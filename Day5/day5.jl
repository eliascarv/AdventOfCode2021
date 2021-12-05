using LinearAlgebra

# Data
segments = map(readlines(joinpath(@__DIR__, "input.txt"))) do line
    p1, p2 = split(line, " -> ")
    x1, y1 = parse.(Int, split(p1, ","))
    x2, y2 = parse.(Int, split(p2, ","))

    x = x1 < x2 ? 1 : -1
    y = y1 < y2 ? 1 : -1
    step = CartesianIndex(x, y)
    CartesianIndex(x1, y1):step:CartesianIndex(x2, y2)
end

horiz_vert = filter(seg -> size(seg, 1) == 1 || size(seg, 2) == 1, segments)

## Part 1 & 2 -----------------------------------------------------------------
function overlap(segments)
    mark = zeros(Int, 1000, 1000)
    for seg in segments
        if size(seg, 1) == 1 || size(seg, 2) == 1
            mark[seg] .+= 1
        else
            mark[diag(seg)] .+= 1
        end
    end
    return count(>(1), mark)
end

# Solution Part 1: 7644
overlap(horiz_vert)

# Solution Part 2: 18627
overlap(segments)
