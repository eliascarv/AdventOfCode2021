# Data
lines = readlines(joinpath(@__DIR__, "input.txt"))
data = Matrix{Int}(undef, length(lines), length(lines[1]))
for i in axes(data, 1)
    data[i, :] .= parse.(Int, split(lines[i], ""))
end

## Part 1 ---------------------------------------------------------------------
function lowpoints(data)
    nr, nc = size(data)

    idxs = falses(nr, nc)
    for j in axes(data, 2)
        for i in axes(data, 1)
            t = trues(4)
            if i > 1
                data[i-1, j] ≤ data[i, j] && (t[1] = false)
            end
            if i < nr
                data[i+1, j] ≤ data[i, j] && (t[2] = false)
            end
            if j > 1
                data[i, j-1] ≤ data[i, j] && (t[3] = false)
            end
            if j < nc
                data[i, j+1] ≤ data[i, j] && (t[4] = false)
            end
            all(t) && (idxs[i, j] = true)
        end
    end
    return idxs
end

# Solution: 541
sum(x -> x + 1, data[lowpoints(data)])

## Part 2 ---------------------------------------------------------------------
function findbasins(data)
    nr, nc = size(data)
    
    lpidxs = lowpoints(data)
    nb = count(lpidxs)

    basins = zeros(Int, nr, nc)
    basins[lpidxs] .= 1:nb

    for _ in 1:10
        for j in axes(data, 2)
            for i in axes(data, 1)
                data[i, j] == 9 && continue
                basins[i, j] > 0 && continue

                bl = i > 1  ? basins[i-1, j] : 0
                br = i < nr ? basins[i+1, j] : 0
                bb = j > 1  ? basins[i, j-1] : 0
                bt = j < nc ? basins[i, j+1] : 0

                basins[i, j] = max(bl, br, bb, bt)
            end
        end
    end
    return basins
end

# Solution: 847_504
basins = findbasins(data)
largest = sort([count(==(i), basins) for i in 1:maximum(basins)], rev=true)[1:3]
prod(largest)
