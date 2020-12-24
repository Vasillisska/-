function mark_kross(r::Robot)
    for side in (Nord,West,Sud,Ost)
        num_steps=mark_and_enumerate_if_possible!(r,side)
        movements_if_possible!(r,HorizonSide(mod(Int(side)+2,4)),num_steps)
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
end   
    
function mark_and_enumerate_if_possible!(r::Robot,side::HorizonSide)
    num_steps=0
    putmarker!(r)
    while move_if_possible!(r,side)==true
        putmarker!(r)
        num_steps+=1
    end 
    return num_steps
end
    
function movements_if_possible!(r,sides::NTuple{2,HorizonSide},num_steps::Vector{Any})
    for (i,n) in enumerate(num_steps)
        movements_if_possible!(r,sides[mod(i-1,length(sides))+1],n)
    end
end