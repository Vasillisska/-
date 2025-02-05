function pryamoug_bord(r::Robot)
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
    num=0
    num_steps=0
    state=false
    while numsteps!=0 # сделано так , а не через for , т.к. при обходе прямоугольной нужно уменьшать количество шагов
        if isborder(r,side)==false
            move!(r,side)
            numsteps-=1
            if isborder(r,Nord)==true
                state = true
                numbord+=1
            else
                state=false
                if numbord>0
                    num+=check(r,side)
                    numbord=0
                end    
            end  
        else # обходит вертикальную перегородку
            while isborder(r,side)==true
                move!(r,Sud)
                num_steps+=1
            end
            move!(r,side)
            numsteps-=1 
            while isborder(r,Nord)==true # на случай, если мы обходим прямоугольную
                move!(r,side)    
                numsteps-=1
            end        
            for _ in 1:num_steps
                move!(r,Nord)
            end
            num_steps=0
        end
    end
    return(num)
end

function check(r::Robot,side::HorizonSide) # проверяем , имеется ли перегородка , совмещённая с горизонтальной , если да, то значит мы нашли прямоугольную
    num=0
    move!(r,Nord)
    if isborder(r,inverse(side))==true
        num+=1
        move!(r,Sud)
    else
        move!(r,Sud)
    end
    return num
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))


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