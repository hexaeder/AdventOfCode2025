data = "example.txt"
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
    println("Overall sum = ", sum)
end
part1(data)
