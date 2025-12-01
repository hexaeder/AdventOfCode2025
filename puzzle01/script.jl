
input = "/home/hw/dev/AdventOfCode2025/puzzle01/input.txt"
# input = "/home/hw/dev/AdventOfCode2025/puzzle01/inputmin.txt"

function solve_puzzle(input)
    zero_counter = 0
    zero_crossing = 0
    pos = 50
    atzero = false
    for instruction in readlines(input)
        d, n = match(r"^([LR])(.*)$", instruction)
        n = parse(Int, n)
        @assert n > 0

        new_crossings = 0
        new_crossings += div(n, 100)
        n = n % 100

        if d == "L"
            pos -= n
        elseif d == "R"
            pos += n
        end

        if pos < 0
            pos = 100 - ( -pos % 100)
            if !atzero # only count if we were not at zero before
                new_crossings += 1
            end
        elseif pos > 100
            pos = pos % 100
            new_crossings += 1
        elseif pos == 0 || pos == 100
            # new_crossings += 1
            pos = 0 # don't count
        end
        print("$instruction\t => $pos\t")

        # zero_crossing += new_zero_c
        if !iszero(new_crossings)
            println("  -> $new_crossings zero crossing(s)")
        else
            println()
        end
        zero_crossing += new_crossings

        if pos == 0
            zero_counter += 1
            atzero = true
        else
            atzero = false
        end
    end
    @info "Found" zero_counter zero_crossing zero_counter+zero_crossing
end
solve_puzzle(input)
