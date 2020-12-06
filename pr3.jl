function mark_all(r::Robot)
    numsteps_vert=moveto!(r,Sud)
    numsteps_hor=moveto!(r,West)
    putmarker!(r)
    while isborder(r,Nord)==false 
        for side in (Ost,West)
            while isborder(r,side)==false
                move!(r,side)
                putmarker!(r)
            end
            move!(r,Nord)
            putmarker!(r)
        end
    end
    while isborder(r,Ost)==false
        move!(r,Ost)
        putmarker!(r)
    end
    moves!(r,Sud)
    moves!(r,West)

    back(r,Ost,numsteps_hor)
    back(r,Nord,numsteps_vert)
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

function moves!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end        