# Data
lines = readlines(joinpath(@__DIR__, "input.txt"))
data = Matrix{Int}(undef, length(lines), length(lines[1]))
for i in axes(data, 1)
    data[i, :] .= parse.(Int, split(lines[i], ""))
end

## Part 1 -----------------------------------------------------
const CI = CartesianIndex

step!(data, i::CI) = data[i] == 9 ? data[i] = 0 : data[i] += 1

const adj = setdiff(CI(-1, -1):CI(1, 1), [CI(0, 0)])

function flash!(data, idxs::CartesianIndices, i::CI)
    for a in adj .+ [i]
        if a ∈ idxs && data[a] ≠ 0
            step!(data, a)
            data[a] == 0 && flash!(data, idxs, a)
        end
    end
end

function step!(data, idxs::CartesianIndices) 
    for i in idxs
        step!(data, i)
    end
    is = filter(i -> data[i] == 0, idxs)
    for i in is
        flash!(data, idxs, i)
    end
end

function countflash(init, steps::Int)
    data = copy(init)
    idxs = CartesianIndices(data)
    flashs = 0
    for _ in 1:steps
        step!(data, idxs)
        flashs += count(iszero, data)
    end
    return flashs
end

# Solution: 1637
countflash(data, 100)

## Part 2 -----------------------------------------------------
function allflash(init)
    data = copy(init)
    idxs = CartesianIndices(data)
    st = 1
    while true
        step!(data, idxs)
        all(iszero, data) && break
        st += 1
    end
    return st
end
# Solution: 242
allflash(data)
