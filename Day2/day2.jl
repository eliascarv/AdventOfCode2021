# Data
using DelimitedFiles

data = readdlm(joinpath(@__DIR__, "input.txt"))
cmds = String.(data[:, 1])
vals = Int.(data[:, 2])

## Part 1 -------------------------------------------
function positions1(cmds, vals)
    hposition = 0
    depth = 0

    for (cmd, val) in zip(cmds, vals)
        cmd == "forward" && (hposition += val)
        cmd == "down" && (depth += val)
        cmd == "up" && (depth -= val)
    end

    return hposition, depth
end

# Solution: 2272262
prod(positions1(cmds, vals))

## Part 2 -------------------------------------------
function positions2(cmds, vals)
    hposition = 0
    depth = 0
    aim = 0

    for (cmd, val) in zip(cmds, vals)
        if cmd == "forward" 
            hposition += val
            depth += val * aim
        end
        cmd == "down" && (aim += val)
        cmd == "up" && (aim -= val)
    end

    return hposition, depth
end

# Solution: 2134882034
prod(positions2(cmds, vals))
