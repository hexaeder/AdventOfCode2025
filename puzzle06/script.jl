using LinearAlgebra
# data = "example.txt"
data = "input.txt"

REDUCER_MAP = Dict(
    "*" => *,
    "+" => +,
)
function part1(data)
    lines = collect(readlines(data))
    Ncols = length(split(lines[begin], r"\s+"))
    cols = [Int[] for _ in 1:Ncols]
    for l in lines[1:end-1]
        nums = parse.(Int, split(l))
        for (num, col) in zip(nums, cols)
            push!(col, num)
        end
    end
    reducers = getindex.(Ref(REDUCER_MAP), split(lines[end]))
    sum = mapreduce(+, zip(reducers, cols)) do (red, col)
       reduce(red, col)
    end
    println("PART 1 sum = ", sum)
end
part1(data)

function part2(data)
    lines = collect(readlines(data))
    reducers = getindex.(Ref(REDUCER_MAP), split(lines[end]))
    Ncols = mapreduce(length, max, lines)
    cols = [Union{Int,Nothing}[] for _ in 1:Ncols]
    for l in lines[1:end-1]
        lpaded = rpad(l, Ncols)
        nums = [tryparse(Int, string(s)) for s in lpaded]
        for (num, col) in zip(nums, cols)
            push!(col, num)
        end
    end
    cols

    groups = Vector{Vector{Vector{Union{Nothing,Int}}}}()
    i = 1
    while i <= length(cols)
        thisgroup = Vector{Vector{Union{Nothing,Int}}}()
        while i <= length(cols) && !all(isnothing, cols[i])
            push!(thisgroup, filter(!isnothing, cols[i]))
            i += 1
        end
        push!(groups, thisgroup)
        i += 1
    end

    sum = mapreduce(+, zip(reducers, groups)) do (red, group)
        mapreduce(red, group) do col
            LinearAlgebra.dot(reverse(col), [10^(i-1) for i in 1:length(col)])
        end
    end
    println("PART 2 sum = ", sum)
end
part2(data)
