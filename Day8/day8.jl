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
# Solution: 383
sum(count.(str -> length(str) ∈ [2, 3, 4, 7], outputs))

## Part 2 -------------------------------------------------
sortstring(str) = join(sort(collect(str)))

function decode(input)
    sorted = sortstring.(input)
    dec = Dict{String, Int}()
    for str in sorted
        length(str) == 2 && (dec[str] = 1)
        length(str) == 4 && (dec[str] = 4)
        length(str) == 3 && (dec[str] = 7)
        length(str) == 7 && (dec[str] = 8)
    end
    code = Dict(reverse(kv) for kv in dec)
    for str in setdiff(sorted, keys(dec))
        if length(str) == 6
            (code[4] ⊆ str && code[7] ⊆ str) && (dec[str] = 9)
            (code[4] ⊈ str && code[7] ⊆ str) && (dec[str] = 0)
            (code[4] ⊈ str && code[7] ⊈ str) && (dec[str] = 6)
        end
    end
    code = Dict(reverse(kv) for kv in dec)
    for str in setdiff(sorted, keys(dec))
        code[1] ⊆ str && (dec[str] = 3)
        str ⊆ code[6] && (dec[str] = 5)
        str ⊈ code[9] && (dec[str] = 2)
    end
    return dec
end

function getnum(dec, output)
    sorted = sortstring.(output)
    nums = [dec[str] for str in sorted]
    return evalpoly(10, reverse(nums))
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
