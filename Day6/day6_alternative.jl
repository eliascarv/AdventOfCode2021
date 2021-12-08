# Alternative solution by David Neuzerling (https://github.com/mdneuzerling)
# ref: https://github.com/mdneuzerling/advent_of_code/blob/main/AOC2021/src/day06.jl

# Data
line = readline(joinpath(@__DIR__, "input.txt"))
data = parse.(Int, split(line, ","))

## Part 1 & 2 ---------------------------------------
const M = [
    0 1 0 0 0 0 0 0 0
    0 0 1 0 0 0 0 0 0
    0 0 0 1 0 0 0 0 0
    0 0 0 0 1 0 0 0 0
    0 0 0 0 0 1 0 0 0
    0 0 0 0 0 0 1 0 0
    1 0 0 0 0 0 0 1 0
    0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0
]

function simulate(init, ndays)
    counts = [count(==(i), init) for i in 0:8]
    sim = M^ndays * counts
    return sum(sim)
end

# Part 1 solution: 375_482
simulate(data, 80)

# Part 2 solution: 1_689_540_415_957
simulate(data, 256)
