# data = "example.txt"
data = "input.txt"

function part1(data)
    ranges = UnitRange{Int}[]
    fresh_ids = Int[]
    part = :ranges
    for l in eachline(data)
        if isempty(l)
            part = :ids
            continue
        end
        if part == :ranges
            first, second = split(l, "-")
            push!(ranges, parse(Int, first):parse(Int, second))
        elseif part == :ids
            id = parse(Int, l)
            if any(range -> id ∈ range, ranges)
                # println("Found fresh ID $id")
                push!(fresh_ids, id)
            end
        end
    end
    println("PART 1: Found $(length(fresh_ids)) fresh ids!")
    return ranges
end

ranges = part1(data)

function trymerge(A, B)
    @assert first(A) <= first(B)
    if first(B) > last(A) + 1
        return nothing
    else
        return first(A):max(last(A),last(B))
    end
end
function unique_ids_in_ranges(ranges)
    sort!(ranges, by=first)
    compact_ranges = UnitRange{Int}[]
    push!(compact_ranges, ranges[1])
    for i in 2:length(ranges)
        last = compact_ranges[end]
        merger = trymerge(last, ranges[i])
        if !isnothing(merger)
            compact_ranges[end] = merger
        else
            push!(compact_ranges, ranges[i])
        end
    end
    total = mapreduce(length, +, compact_ranges)
    println("PART 2: Found total of $total fresh ids!")
end
unique_ids_in_ranges(ranges)
