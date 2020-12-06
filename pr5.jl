function mark_corner(r::Robot)
    
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West)==false
        push!(num_steps, moves!(r, West)) 
        push!(num_steps, moves!(r, Sud))
    end


    putmarker!(r)

    for side in (Nord,Ost,Sud,West)
        moveto!(r,side)
        putmarker!(r)
    end
    
    for (i,n) in enumerate(reverse!(num_steps))
        side = isodd(i) ? Nord : Ost
        moves!(r,side,n)
    end
end

function moves!(r::Robot,side::HorizonSide)
    numsteps=0
    while isborder(r,side)==false
        move!(r,side)
        numsteps+=1
    end
    return numsteps
end

function moveto!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end
          
moves!(r,side,num_steps) = for _ in 1:num_steps move!(r,side) end    