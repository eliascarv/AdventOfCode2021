## Data ----------------------------------------------------
lines = readlines(joinpath(@__DIR__, "input.txt"))
data = Matrix{Int}(undef, length(lines), length(lines[1]))
for i in axes(data, 1)
    data[i, :] .= parse.(Int, split(lines[i], ""))
end

# WIP