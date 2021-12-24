## Data -----------------------------------------------------------------------
lines = readlines(joinpath(@__DIR__, "input.txt"))

template = lines[1]
rulers = Dict(p => r for (p, r) in split.(lines[3:end], " -> "))

## Functions ------------------------------------------------------------------
function simulate(template, rulers, steps)
    sim = Dict(p => count(p, template, overlap=true) for p in keys(rulers))
    for _ in 1:steps
        temp = filter(p -> last(p) > 0, sim)
        for p in keys(temp)
            sim[p] -= temp[p]
            sim[p[1]*rulers[p]] += temp[p]
            sim[rulers[p]*p[2]] += temp[p]
        end
    end
    return sim
end

function countchars(template, sim)
    counts = Dict{Char, Int}()
    for char in 'A':'Z'
        counts[char] = sum(values(filter(p -> endswith(first(p), char), sim)))
    end
    counts[template[1]] += 1
    return filter(p -> last(p) > 0, counts)
end

## Part 1 ---------------------------------------------------------------------
sim1 = simulate(template, rulers, 10)

# Solution: 2194
counts = values(countchars(template, sim1))
maximum(counts) - minimum(counts)

## Part 2 ---------------------------------------------------------------------
sim2 = simulate(template, rulers, 40)

# Solution: 2360298895777
counts = values(countchars(template, sim2))
maximum(counts) - minimum(counts)
