data = parse.(Int, split(readline(joinpath(@__DIR__, "input.txt")), ','))

function simulate(init, ndays)
    sim = Dict(
        0 => count(==(0), init),
        1 => count(==(1), init),
        2 => count(==(2), init),
        3 => count(==(3), init),
        4 => count(==(4), init),
        5 => count(==(5), init),
        6 => count(==(6), init),
        7 => count(==(7), init),
        8 => count(==(8), init)
    )
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

simulate(data, 80)

simulate(data, 256)
