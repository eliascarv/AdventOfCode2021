# Data
line = readline(joinpath(@__DIR__, "input.txt"))
data = parse.(Int, split(line, ","))

## Part 1 -----------------------------------------
dists(x, k) = abs.(x .- k)
cost1(x, k) = sum(dists(x, k))

# Solution: 344_138
minimum(cost1(data, k) for k in 0:maximum(data))

## Part 2 -----------------------------------------
function cost2(x, k) 
    ds = dists(x, k)
    sum((ds + ds.^2) .÷ 2)
end

# Solution: 94_862_124
minimum(cost2(data, k) for k in 0:maximum(data))
