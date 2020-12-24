function mark_rectangle_perimeter(r)
    num_steps=SudWestAngle(r,(Sud,West)) # перемещаем робота в юго-западный угол , записывая шаги в массив
    direction=Ost
    while (isborder(r,Nord)==false) 
        if isborder(r,direction)
            direction=inverse(direction)
            move!(r,Nord)
        else move!(r,direction)
        end
    end
    while (ismarker(r)==false)
        putmarker!(r)
        if isborder(r,right(direction))
        move!(r,direction)
        else
        direction=right(direction)
        move!(r,direction)
        end
    end
    SudWestAngle(r,(Sud,West)) # перемещаем в юго-западный угол
    moveto!(r,(Nord,Ost),reverse(num_steps)) # возвращаем в исходное положение
end
function get_num(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps+=1    
    end
    return num_steps
end
            
function moveto!(r,sides::NTuple{2,HorizonSide},num_steps::Vector{Any})
    for (i,n) in enumerate(num_steps)
        movements!(r,sides[mod(i-1,length(sides))+1],n)
    end
end
                    
function SudWestAngle(r,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while (isborder(r,angle[1])==false || isborder(r,angle[2])==false)
        push!(num_steps,get_num(r,angle[2]))
        push!(num_steps,get_num(r,angle[1]))
    end
    return num_steps
    end