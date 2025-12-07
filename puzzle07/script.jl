# data = "example.txt"
data = "input.txt"


function split_beam(beam, splitter)
    newbeam = zeros(eltype(beam), length(beam))
    hitsplitters = 0
    for i in eachindex(beam, splitter, newbeam)
        beam[i] == 0 && continue
        if splitter[i]
            hitsplitters += 1
            newbeam[i-1] += beam[i]
            newbeam[i]   = 0
            newbeam[i+1] += beam[i]
        else
            newbeam[i] += beam[i]
        end
    end
    return hitsplitters, newbeam
end

function showbeam(beam)
    for i in beam
        print(i == 0 ? " " : i)
        print(" ")
    end
    println()
end
function part1(data)
    lines = eachline(data)
    first = iterate(lines)[1]
    beam = zeros(Int, length(first))
    beam[only(findfirst("S", first))] = 1
    hitsplitters = 0
    for l in lines
        splitter = [c=='^' for c in l]
        hs, newbeam = split_beam(beam, splitter)
        hitsplitters += hs
        beam = newbeam
        # showbeam(beam)
    end
    println("PART 1: Hit $hitsplitters spliters along the way")
    println("PART 2: We arived in $(sum(beam)) worlds")
end

part1(data)
