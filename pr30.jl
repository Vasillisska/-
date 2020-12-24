function mark_it_all(r::Robot)
    numsteps_hor=moveto!(r,West)
    numsteps_vert=moveto!(r,Sud)
    while isborder(r,Nord)==false || isborder(r,West)==false || ismarker(r)==false # пока не вернёмся в северо-западный угол(оттуда проще вернуться в начальную точку)
        for side in (Ost,West)    
            putmark(r,side)
            putmarker!(r) # маркер в точке остановки
            if isborder(r,Nord)==false
                move!(r,Nord)
            end
        end
    end
    moves(r,Sud) # перемещаемся в юго-западный
    back(r,Nord,numsteps_vert) # возвращаемся в начальную точку
    back(r,Ost,numsteps_hor)
end

function putmark(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        if ismarker(r)==false
            putmarker!(r)
            move!(r,side)
        else
            move!(r,side)
        end    
    end
end            

function moveto!(r::Robot,side::HorizonSide)
    numsteps=0
    while isborder(r,side)==false
        move!(r,side)
        numsteps+=1
    end
    return numsteps
end

function back(r::Robot,side::HorizonSide,numsteps::Int)
    for _ in 1:numsteps
        move!(r,side)
    end
end     

function moves(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end       