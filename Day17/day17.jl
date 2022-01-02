## Data ---------------------------------------------------
line = readline(joinpath(@__DIR__, "input.txt"))

nums = getproperty.(eachmatch(r"[\-0-9]+", line), :match)

x = parse.(Int, nums[1:2])
y = parse.(Int, nums[3:4])

# Part 1 --------------------------------------------------
nextstep(p, v) = p .+ v, (v[1] - sign(v[1]), v[2] - 1)

function highest_y(v)
    p, ymax = (0, 0), 0
    while p[2] ≥ 0
        p, v = nextstep(p, v)
        ymax = max(p[2], ymax)
    end
    return ymax
end

# Solution: 33670
highest_y((1, abs(y[1] + 1)))

# Part 2 --------------------------------------------------
function checkvalid!(valid, start, x1, x2, y1, y2)
    p, v = (0, 0), start
    while p[2] ≥ y1 && p[1] ≤ x2
        p, v = nextstep(p, v)
        if (x1 ≤ p[1] ≤ x2) && (y1 ≤ p[2] ≤ y2)
            push!(valid, start)
            break
        end
    end
end

function solve((x1, x2), (y1, y2))
    valid = Set{NTuple{2, Int}}()
    for x in 1:x2
        for y in y1:abs(y1)
            checkvalid!(valid, (x, y), x1, x2, y1, y2)
        end
    end
    return valid
end

# Solution: 4903
length(solve(x, y))
