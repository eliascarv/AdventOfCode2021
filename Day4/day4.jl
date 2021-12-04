# Data
data = readlines(joinpath(@__DIR__, "input.txt"))

nums = parse.(Int, split(data[1], ','))

n = length(data) ÷ 6
boards = Vector{Matrix{Int}}(undef, n)
for (i, j) in enumerate(3:6:length(data))
    boards[i] = Matrix{Int}(undef, 5, 5)
    for k in 1:5
        boards[i][k, :] .= parse.(Int, split(data[j+k-1]))
    end
end

## Part 1 -------------------------------------------------
function winfirst(boards, nums)
    set = nums[1:5]

    for n in nums[6:end]
        for board in boards
            for col in eachcol(board)
                col ⊆ set && return board, set
            end
            for row in eachrow(board)
                row ⊆ set && return board, set
            end
        end
        push!(set, n)
    end

    return last(boards), nums
end

function score(board, nums)
    l = last(nums)
    s = sum(board[findall(i -> i ∉ nums, board)])
    return l * s
end

# Solution: 74320
score(winfirst(boards, nums)...)

## Part 2 -------------------------------------------------
function winlast(boards, nums)
    set = nums[1:5]
    win = falses(length(boards))
    
    for n in nums[6:end]
        for (i, board) in enumerate(boards)
            if win[i] == false
                for col in eachcol(board)
                    col ⊆ set && (win[i] = true)
                end
                for row in eachrow(board)
                    row ⊆ set && (win[i] = true)
                end
            end
            all(win) && return board, set
        end
        push!(set, n)
    end

    return last(boards), nums
end

# Solution: 17884
score(winlast(boards, nums)...)
