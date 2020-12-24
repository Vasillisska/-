function horiz_borders(r::Robot)
    while isborder(r,West)==false || isborder(r,Sud)==false # Перемещаем робота в юго-западный угол
        moves!(r,Sud)
        moves!(r,West)
    end
    num_steps=moveto!(r,Ost) # определяем размер поля
    numbord=0
    while isborder(r,Nord)==false || isborder(r,Ost)==false # пока не дойдёт до верхней границы поля
        for side in(West,Ost)
            if isborder(r,Nord)==true && isborder(r,Ost)==true # дошёл до верхней границы  поля
                break
            end    
            numbord+=search_bord(r,side,num_steps)
            if isborder(r,Nord)==false
                move!(r,Nord)
            end    
        end    
    end   
    print(numbord)
end  

function search_bord(r::Robot,side::HorizonSide,numsteps::Int)
    numbord=0
    num_steps=0
    state=false
    for _ in 1:numsteps
        if isborder(r,side)==false
            move!(r,side)
            if isborder(r,Nord)==true && state==false
                numbord += 1
                state = true
            else
                state=false
            end    
        else # обходит вертикальную перегородку
            while isborder(r,side)==true
                move!(r,Sud)
                num_steps+=1
            end      
            move!(r,side)       
            for _ in 1:num_steps
                move!(r,Nord)
            end
            num_steps=0
        end
    end                   
    return(numbord)
end            

function moves!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function moveto!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end        