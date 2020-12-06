function mark_perimetr(r::Robot)
    numsteps_vert=moveto!(r,Sud)
    numsteps_hor=moveto!(r,West)
    putmarker!(r)
    for side in (Ost,Nord,West,Sud)
        while isborder(r,side)==false
            move!(r,side)
            putmarker!(r)
        end        
    end
    back(r,Nord,numsteps_vert)
    back(r,Ost,numsteps_hor)
end


function moveto!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end        

function back(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end        
