# data = "example.txt"
data = "input.txt"

function parse_matrix(data)
    width = length(first(readlines(data)))
    M = Matrix{Int}(undef, 0, width)
    ldat_buf = zeros(Int, width)
    for lstr in readlines(data)
        # lstr = first(readlines(data))
        for i in 1:width
            ldat_buf[i] = lstr[i] == '@' ? 1 : 0
        end
        M = vcat(M, ldat_buf')
    end
    return M
end

M = parse_matrix(data)

function count_neighbors(M, i)
    neighbors = [
        i + CartesianIndex(-1, -1),
        i + CartesianIndex(-1,  0),
        i + CartesianIndex(-1,  1),
        i + CartesianIndex( 0, -1),
        i + CartesianIndex( 0,  1),
        i + CartesianIndex( 1, -1),
        i + CartesianIndex( 1,  0),
        i + CartesianIndex( 1,  1),
    ]
    mapreduce(+, neighbors) do i
        checkbounds(Bool, M, i) ? M[i] : 0
    end
end

function count_neighbors(M)
    accessible = 0
    for ci in eachindex(IndexCartesian(), M)
        iszero(M[ci]) && continue
        nb = count_neighbors(M, ci)
        if nb < 4
            accessible += 1
        end
    end
    accessible
end

@show count_neighbors(M)
