# Data
using DelimitedFiles

const data = readdlm("input.txt")
const oprs = String.(data[:, 1])
const vals = Int.(data[:, 2])

# Part 1 --------------------------------------------------------------
function positions1(oprs, vals)
    hposition = 0
    depth = 0

    for (opr, val) in zip(oprs, vals)
        opr == "forward" && (hposition += val)
        opr == "down" && (depth += val)
        opr == "up" && (depth -= val)
    end

    return hposition, depth
end

# Solution: 2272262
prod(positions1(oprs, vals))

# Part 2 --------------------------------------------------------------
function positions2(oprs, vals)
    hposition = 0
    depth = 0
    aim = 0

    for (opr, val) in zip(oprs, vals)
        if opr == "forward" 
            forward = val
            hposition += forward
            depth += forward * aim
        end
        opr == "down" && (aim += val)
        opr == "up" && (aim -= val)
    end

    return hposition, depth
end

# Solution: 2134882034
prod(positions2(oprs, vals))
