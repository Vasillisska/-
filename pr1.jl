function mark_kross(r::Robot)
    for side in (Nord,Sud,West,Ost)
        numsteps=moveto!(r,side)
        back(r,inverse(side),numsteps)
    end
    putmarker!(r)
end

function moveto!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
        num_steps+=1
    end
    return num_steps
end
function back(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end    

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))