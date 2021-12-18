using SparseArrays

## Data -------------------------------------------------------------
lines = readlines(joinpath(@__DIR__, "input.txt"))

const CI = CartesianIndex

function parsedata(lines)
    l = length(lines)
    n = findfirst(isempty, lines)
    idxs = Vector{CI{2}}(undef, n - 1)
    folds = Vector{Pair{Symbol, Int}}(undef, l - n)
    for i in 1:n-1
        x, y = parse.(Int, split(lines[i], ","))
        idxs[i] = CI(y + 1, x + 1)
    end
    for i in n+1:l
        var, val = split(lines[i][12:end], "=")
        folds[i-n] = Symbol(var) => parse(Int, val)
    end
    ymax = maximum(i -> i[1], idxs)
    xmax = maximum(i -> i[2], idxs)
    data = sparse(zeros(Int, ymax, xmax))
    data[idxs] .= 1
    return data, folds
end

data, folds = parsedata(lines)

## Part 1 -----------------------------------------------------------
hrot(M) = hcat([reverse(col) for col in eachcol(M)]...)
vrot(M) = permutedims(hcat([reverse(row) for row in eachrow(M)]...))

function foldpaper(data, fold::Pair{Symbol, Int})
    v = fold[1]
    n = fold[2] + 1
    if v == :y
        M = data[1:n-1, :] + hrot(data[n+1:end, :])
    elseif v == :x
        M = data[:, 1:n-1] + vrot(data[:, n+1:end])
    end
    return M
end

# Solution: 653
count(>(0), foldpaper(data, folds[1]))

## Part 2 -----------------------------------------------------------
function foldpaper(data, folds::Vector{Pair{Symbol, Int}})
    for fold in folds
        data = foldpaper(data, fold)
    end
    return data
end

# Solution: LKREBPRK
foldpaper(data, folds)
