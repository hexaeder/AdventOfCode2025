# data = "example.txt"
data = "input.txt"

function parse_ranges(data)
    parts = split(read(data, String),",")
    ranges = UnitRange{Int}[]
    for p in parts
        first, second = split(p, "-")
        push!(ranges, parse(Int, first):parse(Int, second))
    end
    ranges
end
ranges = parse_ranges(data)

function expand_ranges(ranges)
    ids = Int[]
    for r in ranges
        append!(ids, collect(r))
    end
    ids
end
ids = expand_ranges(ranges)

function is_invalid(i)
    s = string(i)
    l = length(s)
    isodd(l) && return false
    part = (1:l÷2, l÷2+1:l)
    s[part[1]] == s[part[2]]
end

invalid = is_invalid.(ids)
ids[invalid]
sum(ids[invalid])

function invalid_for_devisor(s, d)
    l = length(s)
    nparts = l ÷ d
    partl = l ÷ nparts
    ranges = [i*partl + 1 : i*partl+partl for i in 0:nparts-1]
    allequal(range -> s[range], ranges)
end

function is_invalid_2(i)
    s = string(i)
    l = length(s)
    devisors = [i for i in 1:floor(Int, l/2) if mod(l,i)==0]
    d=1
    any(d -> invalid_for_devisor(s, d), devisors)
end
invalid = is_invalid_2.(ids)
invlaid_ids = ids[invalid]
sum(invlaid_ids)
