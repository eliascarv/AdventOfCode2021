# Data
data = parse.(Int, split(readline(joinpath(@__DIR__, "input.txt")), ','))

## Part 1 & 2 -------------------------------------------------------------
function simulate(init, ndays)
    sim = Dict(i => count(==(i), init) for i in 0:8)
    idx = vcat(0:5, 7)

    for _ in 1:ndays
        old = copy(sim)
        for i in idx
            sim[i] = old[i+1]
        end
        sim[6] = old[7] + old[0]
        sim[8] = old[0]
    end

    return sum(values(sim))
end

# Solution Part 1: 375_482
simulate(data, 80)

# Solution Part 2: 1_689_540_415_957
simulate(data, 256)
