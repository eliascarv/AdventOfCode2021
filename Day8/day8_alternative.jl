# Alternative solution for Part 2 by Jerry Ling (https://github.com/Moelf)
# ref: https://twitter.com/l_II_llI/status/1468610582702174222
lines = readlines(joinpath(@__DIR__, "input.txt")) 

# Compact version
sum(
    parse.(
        Int, 
        ["4725360918"[[sum([L...] .∈ r) ÷ 2 % 15 % 11 + 1 for r in split(R)]] for (L, R) in split.(lines, "|")]
    )
)

# Detailed version
outputs = Vector{Int}(undef, length(lines)) 
for (i, line) in enumerate(lines) 
    inp, out = split(line, "|") 
    idxs = [sum([inp...] .∈ r) ÷ 2 % 15 % 11 + 1 for r in split(out)] 
    num = "4725360918"[idxs] 
    outputs[i] = parse(Int, num) 
end 
sum(outputs)
