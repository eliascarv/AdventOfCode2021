# Optimal solutions by Abel Siqueira (https://github.com/abelsiqueira)
# ref: https://github.com/abelsiqueira/advent-of-code-2021/blob/main/day-07/main.jl
using Statistics

# Data
line = readline(joinpath(@__DIR__, "input.txt"))
data = parse.(Int, split(line, ","))

## Part 1 -----------------------------------------
dists(x, k) = abs.(x .- k)
cost1(x, k) = sum(dists(x, k))

# Optimal solution: 344_138
m = Int(median(data))
cost1(data, m)

## Part 2 -----------------------------------------
function cost2(x, k) 
    ds = dists(x, k)
    # Or: (ds + ds.^2) .÷ 2
    sum(ds .* (ds .+ 1) .÷ 2)
end

# Optimal solution: 94_862_124
μ = mean(data)
μ⁻, μ⁺ = floor(Int, μ), ceil(Int, μ)
min(cost2(data, μ⁻), cost2(data, μ⁺))
