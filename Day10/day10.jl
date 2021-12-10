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

function point1(strs)
    val = Dict(")" => 3, "]" => 57, "}" => 1197, ">" => 25137)
    return sum(str -> val[str], strs)
end

# Solution: 367_059
point1(firstillegal(data))

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

function point2(lines)
    val = Dict(")" => 1, "]" => 2, "}" => 3, ">" => 4)
    points = map(lines) do line
        reduce((pt, str) -> 5pt + val[str], line, init=0)
    end
    mid = ceil(Int, length(lines)/2)
    sort!(points)
    return points[mid]
end

# Solution: 1_952_146_692
point2(incomplete(data))
