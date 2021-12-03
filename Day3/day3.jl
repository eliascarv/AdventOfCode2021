# Data
vecofvec = map(readlines(joinpath(@__DIR__, "input.txt"))) do line
    parse.(Bool, split(line, ""))
end

data = permutedims(hcat(vecofvec...))

# lines = readlines(joinpath(@__DIR__, "input.txt"))
# data = Matrix{Int}(undef, length(lines), length(lines[1]))

# for (i, line) in enumerate(lines)
#     data[i, :] .= parse.(Int, split(line, ""))
# end

# Utility function
binary2int(str::AbstractString) = parse(Int, str, base=2)
binary2int(vector::Vector{Int}) = binary2int(string(vector...))
binary2int(array::BitArray) = binary2int(string(Int.(array)...))

## Part 1 -----------------------------------------------------------
function power_consumption(data::BitMatrix)
    mid = size(data, 1) / 2

    γ = map(eachcol(data)) do col
        count(col) > mid ? 1 : 0
    end

    ϵ = map(eachcol(data)) do col
        count(col) < mid ? 1 : 0
    end

    return binary2int(γ) * binary2int(ϵ)
end

# Solution: 1092896
power_consumption(data)

## Part 2 -----------------------------------------------------------
function rating(data::BitMatrix, compare::Function)
    idxs = collect(axes(data, 1))
    for col in axes(data, 2)        
        mid = size(data[idxs, col], 1) / 2
        x = compare(data, idxs, col, mid)

        idxs = idxs[findall(data[idxs, col] .== x)]
        
        length(idxs) == 1 && break        
    end
    return binary2int(data[idxs, :])
end

oxygen(data, idxs, col, mid) = count(data[idxs, col]) ≥ mid ? 1 : 0

co2(data, idxs, col, mid) = count(data[idxs, col]) ≥ mid ? 0 : 1

life_support(data) = rating(data, oxygen) * rating(data, co2)

# Solution: 4672151
life_support(data)
