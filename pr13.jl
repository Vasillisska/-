function mark_kross_x(r::Robot)
    for side in ((Up, Right), (Down, Right), (Down, Left), (Up, Left))
        diagonalputmarker!(r,side)
        return_back!(r, side)
    end
    putmarker!(r)
end

function diagonalputmarker!(r::Robot, side::NTuple{2, HorizonSide}) # ставим маркеры , двигаясь диагонально
    while isborder(r, side) == false
        diagonalmove(r, side)
        putmarker!(r)
    end
end

function return_back!(r::Robot, side::NTuple{2,HorizonSide}) # возвращаемся в стартовую точку
    while ismarker(r) 
        diagonalmove(r, inverse(side))
    end
end

function diagonalmove(r::Robot, side::NTuple{2,HorizonSide})
    move!(r, side[1])
    move!(r, side[2])
end

isborder(r::Robot,side::NTuple{2,HorizonSide})::Bool = (isborder(r,side[1]) || isborder(r,side[2]))

function inverse(side::NTuple{2,HorizonSide})
    (inverse(side[1]), inverse(side[2]))
end
