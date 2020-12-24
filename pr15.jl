function mark_perimeter(r::Robot)
    num_steps=SudWestAngle(r,(Sud,West))
    side=Nord
    for i in 0:1:3
        putmarkers_if_possible!(r,side)
        side=right(side)
    end
    movements_if_possible!(r,(Nord,Ost),reverse(num_steps))
end

function get_num(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false 
        move!(r,side) 
        num_steps+=1    
    end
    return num_steps
end
    
function SudWestAngle(r,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while (isborder(r,angle[1])==false || isborder(r,angle[2])==false)
        push!(num_steps,get_num(r,angle[2]))
        push!(num_steps,get_num(r,angle[1]))
    end
    return num_steps
end
    
function putmarkers_if_possible!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while move_if_possible!(r, side) == true
        putmarker!(r)
    end
end
    
function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    left_side=HorizonSide(mod(Int(direct_side)-1,4))
    right_side=HorizonSide(mod(Int(left_side)+2,4))
    num_of_steps=0
    if isborder(r,direct_side)==false
        move!(r,direct_side)
        result=true
    else
        while isborder(r,direct_side)==true
            if isborder(r,left_side)==false
                move!(r,left_side)
                num_of_steps+=1
            else
                break
            end
        end
        if isborder(r,direct_side)==false
            move!(r,direct_side)
            while isborder(r,right_side)==true
                move!(r,direct_side)
            end
        result=true
        else
            result=false
        end
        while num_of_steps>0
            num_of_steps-=1
            move!(r,right_side)
        end
    end
    return result
end
    