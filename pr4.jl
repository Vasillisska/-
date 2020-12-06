function mark_except(r::Robot)
    numsteps_hor=moveto!(r,West)
    numsteps_vert=moveto!(r,Sud)
    putmarker!(r)
    numsteps=0
    skipsteps=0

    while isborder(r,Ost)==false
        move!(r,Ost)
        putmarker!(r)
        numsteps+=1
    end  

    while isborder(r,Nord)==false
        for side in (West,Ost)
            numsteps-=1
            skipsteps+=1        
            move!(r,Nord)
            exception(r,side,numsteps,skipsteps)
         end
    end

    moves!(r,West)
    moves!(r,Sud)

    back(r,Ost,numsteps_hor)
    back(r,Nord,numsteps_vert)
end   

function exception(r::Robot,side::HorizonSide,numsteps::Int,skipsteps::Int)
    if side==West
        for _ in 1:skipsteps
            move!(r,side)
        end
        putmarker!(r)
        for _ in 1:numsteps
            move!(r,side)
            putmarker!(r)
        end   
    else
        putmarker!(r)
        for _ in 1:numsteps
            move!(r,side)
            putmarker!(r)
        end
        for _ in 1:skipsteps
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

function moves!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function back(r::Robot,side::HorizonSide,numsteps::Int)
    for _ in 1:numsteps
        move!(r,side)
    end
end        
