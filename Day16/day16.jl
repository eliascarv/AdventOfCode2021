line = readline(joinpath(@__DIR__, "input.txt"))
line = "D2FE28"

bin2int(str) = parse(Int, str, base=2)

hexs = parse.(UInt8, split(line, ""), base=16)
bin = join(string.(hexs, base=2, pad=4))

function literal(str)
    litval, start, x = "", '1', 1
    while start == '1'
        start = str[x]
        litval = litval * str[x+1:x+4]
        x += 5
    end
    bin2int(litval), x + 6
end


function parse2end(str)
    v, lit = 0, Int[]
    while length(str) > 0
        new_v, new_lit, x = dec(str)
        str = str[x:end]
        v += new_v
        push!(lit, new_lit)
    end
    v, lit
end

function op(tp, lit) 
    tp == 4 && return lit
    tp == 0 && return sum(lit)
    tp == 1 && return prod(lit)
    tp == 2 && return minimum(lit)
    tp == 3 && return maximum(lit)
    tp == 5 && return Int(lit[1] > lit[2])
    tp == 6 && return Int(lit[1] < lit[2])
    tp == 7 && return Int(lit[1] == lit[2])
end

function dec(str)
    v, tp = bin2int(str[1:3]), bin2int(str[4:6])
    
    if tp == 4
        lit, x = literal(str[7:end])
        return v, lit, x
    end 
    
    if str[7] == '0'
        x = 23 + bin2int(str[8:22])
        new_v, lit = parse2end(str[23:x-1])
        v += new_v
        return v, op(tp, lit), x
    end

    lit, x = Int[], 19
    for _ in 1:bin2int(str[8:18])
        new_v, new_lit, new_x = dec(str[x:end])
        push!(lit, new_lit)
        v += new_v
        x += new_x -1
    end

    v, op(tp, lit), x
end

p1, p2, _ = dec(bin)
