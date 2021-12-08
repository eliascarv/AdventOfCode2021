# Data
lines = readlines(joinpath(@__DIR__, "input.txt"))
inputs = Vector{Vector{String}}(undef, length(lines))
outputs = Vector{Vector{String}}(undef, length(lines))
for (i, line) in enumerate(lines)
    input, output = split(line, " | ")
    inputs[i] = split(input)
    outputs[i] = split(output)
end

## Part 1 -------------------------------------------------
n1 = sum(count.(str -> length(str) == 2, outputs))
n4 = sum(count.(str -> length(str) == 4, outputs))
n7 = sum(count.(str -> length(str) == 3, outputs))
n8 = sum(count.(str -> length(str) == 7, outputs))

# Solution: 383
n1 + n4 + n7 + n8

## Part 2 -------------------------------------------------
sortstring(str) = string(sort(split(str, ""))...)

function decode(input)
    sorted = sortstring.(input)
    ns = Dict{String, Int}()
    for str in sorted
        length(str) == 2 && (ns[str] = 1)
        length(str) == 4 && (ns[str] = 4)
        length(str) == 3 && (ns[str] = 7)
        length(str) == 7 && (ns[str] = 8)
    end
    st = Dict(reverse(kv) for kv in ns)
    for str in setdiff(sorted, keys(ns))
        if length(str) == 6
            (st[4] ⊆ str && st[7] ⊆ str) && (ns[str] = 9)
            (st[4] ⊈ str && st[7] ⊆ str) && (ns[str] = 0)
            (st[4] ⊈ str && st[7] ⊈ str) && (ns[str] = 6)
        end
    end
    st = Dict(reverse(kv) for kv in ns)
    for str in setdiff(sorted, keys(ns))
        st[1] ⊆ str && (ns[str] = 3)
        str ⊆ st[6] && (ns[str] = 5)
        str ⊈ st[9] && (ns[str] = 2)
    end
    return ns
end

function getnum(dec, output)
    sorted = reverse(sortstring.(output))
    num = 0
    for (i, str) in enumerate(sorted)
        num += dec[str] * 10^(i-1)
    end
    return num
end

function sum_outputs(inputs, outputs)
    s = 0
    for i in eachindex(inputs)
        s += getnum(decode(inputs[i]), outputs[i])
    end
    return s
end

# Solution: 998_900
sum_outputs(inputs, outputs)
