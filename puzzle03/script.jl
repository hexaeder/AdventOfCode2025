using LinearAlgebra
# data = "example.txt"
data = "input.txt"

# function part1(data)
#     sum = 0
#     for line in eachline(data)
#         digits = parse.(Int, collect(line))
#         (first, fi) = findmax(@views digits[1:end-1])
#         (second, si) = findmax(@views digits[fi+1:end])
#         joltage = first*10 + second
#         println("Line $line: $joltage")
#         sum += joltage
#     end
#     sum
# end

# part1(data)

function get_joltage(digits, N)
    chosen_digits = Int[]
    pos = 1
    for i in 1:N
        # @show i
        range = pos:(length(digits) - N + i)
        # @show range
        (thismax, thispos) = findmax(@views digits[range])
        push!(chosen_digits, thismax)
        pos += thispos
        # @show pos
    end

    dot(chosen_digits, [10^i for i in (N-1):-1:0])
end

function part2(data)
    sum = 0
    for line in eachline(data)
        digits = parse.(Int, collect(line))
        joltage = get_joltage(digits, 12)
        println("Line $line: $joltage")
        sum += joltage
    end
    println("Sum = ", sum)
    sum
end

part2(data)
