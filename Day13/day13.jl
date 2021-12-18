using SparseArrays

## Data -------------------------------------------------------------
lines = readlines(joinpath(@__DIR__, "input.txt"))

const CI = CartesianIndex

function parsedata(lines)
    l = length(lines)
    d = findfirst(isempty, lines)
    idxs = Vector{CI{2}}(undef, d - 1)
    folds = Vector{Pair{Symbol, Int}}(undef, l - d)
    for i in 1:d-1
        x, y = parse.(Int, split(lines[i], ','))
        idxs[i] = CI(y + 1, x + 1)
    end
    for i in d+1:l
        v, n = split(lines[i][12:end], '=')
        folds[i-d] = Symbol(v) => parse(Int, n) + 1
    end
    ymax = maximum(i -> i[1], idxs)
    xmax = maximum(i -> i[2], idxs)
    data = sparse(zeros(Int, ymax, xmax))
    data[idxs] .= 1
    return data, folds
end

data, folds = parsedata(lines)

## Part 1 -----------------------------------------------------------
function foldpaper(data, fold::Pair{Symbol, Int})
    v, n = fold
    if v == :y
        data = data[1:n-1, :] + data[end:-1:n+1, :]
    elseif v == :x
        data = data[:, 1:n-1] + data[:, end:-1:n+1]
    end
    return data
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
