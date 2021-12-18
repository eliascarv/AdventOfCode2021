using SparseArrays

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
    y = maximum(i -> i[1], idxs)
    x = maximum(i -> i[2], idxs)
    M = sparse(zeros(Int, y, x))
    M[idxs] .= 1
    return M
end

lines = readlines(joinpath(@__DIR__, "demo.txt"))
M = parsedata(lines)
