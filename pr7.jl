function mark_chess(r)
    num_steps=SudWestAngle(r,(Sud,West)) # робота в юго-западный угол с записью в массив
    direction=Ost 
    put_marker_flag=true
        if (sum(num_steps[1:2:end])%2!=0)
            put_marker_flag=false
        end
    while (isborder(r,Nord)==false) || (isborder(r,Ost)==false)
        if put_marker_flag
            putmarker!(r)
            put_marker_flag=false
        else
            put_marker_flag=true
        end
        if isborder(r,direction)
            direction=inverse(direction)
        move!(r,Nord)
        else move!(r,direction)
        end
    end
    SudWestAngle(r,(Sud,West)) # робот в юго-западном угле
    moveto!(r,(Nord,Ost),reverse(num_steps)) # возвращение в исходное положение
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

function get_num(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps+=1    
    end
    return num_steps
end