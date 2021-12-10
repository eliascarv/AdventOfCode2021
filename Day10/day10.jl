# Data
data = split.(readlines(joinpath(@__DIR__, "input.txt")), "")

## Part 1 -------------------------------------------------------------
function firstillegal(data)
    illegals = String[]

    brktpairs = Dict("[" => "]", "{" => "}", "(" => ")", "<" => ">")
    
    for line in data
        openbrkt = String[]

        for str in line
            if str in keys(brktpairs)
                push!(openbrkt, str)
            elseif str == brktpairs[openbrkt[end]]
                pop!(openbrkt)
            else
                push!(illegals, str)
                break
            end
        end
    end

    return illegals
end

function pt1(strs)
    points = Dict(")" => 3, "]" => 57, "}" => 1197, ">" => 25137)
    return sum(str -> points[str], strs)
end

# Solution: 367_059
pt1(firstillegal(data))

## Part 2 -------------------------------------------------------------
function incomplete(data)
    incompletes = Vector{Vector{String}}()

    brktpairs = Dict("[" => "]", "{" => "}", "(" => ")", "<" => ">")
    
    for line in data
        openbrkt = String[]
        iscorrline = false

        for str in line
            if str in keys(brktpairs)
                push!(openbrkt, str)
            elseif str == brktpairs[openbrkt[end]]
                pop!(openbrkt)
            else
                iscorrline = true
            end
        end

        if !iscorrline
            closing = [brktpairs[str] for str in reverse(openbrkt)]
            push!(incompletes, closing) 
        end
    end

    return incompletes
end

function pt2(lines)
    points = Dict(")" => 1, "]" => 2, "}" => 3, ">" => 4)
    n = length(lines)
    pts = Vector{Int}(undef, n)

    for (i, line) in enumerate(lines)
        pt = 0
        for str in line
            pt = 5pt + points[str]
        end
        pts[i] = pt
    end

    mid = ceil(Int, n/2)
    sort!(pts)
    return pts[mid]
end

# Solution: 1_952_146_692
pt2(incomplete(data))
