function find(r)
    n=0
    side=Ost
    while isborder(r,Nord)
        n+=1
        movements!(r,side,n)
        side=inverse(side)
    end
end

movements!(r::Robot,side::HorizonSide,num_steps::Int)=for _ in 1:num_steps move!(r,side) end