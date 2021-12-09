# Data
lines = readlines(joinpath(@__DIR__, "input.txt"))
data = Matrix{Int}(undef, length(lines), length(lines[1]))
for i in axes(data, 1)
    data[i, :] .= parse.(Int, split(lines[i], ""))
end

test = [
    2 1 9 9 9 4 3 2 1 0
    3 9 8 7 8 9 4 9 2 1
    9 8 5 6 7 8 9 8 9 2
    8 7 6 7 8 9 6 7 8 9
    9 8 9 9 9 6 5 6 7 8
]

function lowpoints(data)
    minrow = mincol = 1
    maxrow, maxcol = size(data)

    points = Int[]
    for j in axes(data, 2)
        for i in axes(data, 1)
            t = trues(4)
            if i - 1 ≥ minrow
                data[i-1, j] ≤ data[i, j] && (t[1] = false)
            end
            if i + 1 ≤ maxrow
                data[i+1, j] ≤ data[i, j] && (t[2] = false)
            end
            if j - 1 ≥ mincol
                data[i, j-1] ≤ data[i, j] && (t[3] = false)
            end
            if j + 1 ≤ maxcol
                data[i, j+1] ≤ data[i, j] && (t[4] = false)
            end
            all(t) && push!(points, data[i, j])
        end
    end
    return points
end

lowpoints(data)
        
sum(x -> x + 1, lowpoints(data))
