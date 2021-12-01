# Data
const data = parse.(Int, readlines("input.txt"))

## Part 1 -------------------------------------------
# Solution
sum(1:length(data)-1) do i
    data[i+1] > data[i]
end

# Alternative solution
sum(diff(data) .> 0)

## Part 2 -------------------------------------------
# Solution
sum(1:length(data)-3) do i
    sum(data[i+1:i+3]) > sum(data[i:i+2])
end

# Alternative solution
# sum([b, c, d]) > sum([a, b, c])
# d + sum([b, c]) > a + sum([b, c])
# d > a
sum(1:length(data)-3) do i
    data[i+3] > data[i]
end
