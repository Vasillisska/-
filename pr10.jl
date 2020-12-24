function gettemperature(r)
    cntr=0
    Temperature=0
    direction=Ost
    while ((isborder(r,Ost)==false) || (isborder(r,Nord)==false)) ## пока не дошли до северо-восточного угла
        if ismarker(r)
            cntr+=1 # количество
            Temperature+=temperature(r) # сумма всех температур
        end
        if isborder(r,direction)
            direction=HorizonSide(mod(Int(direction)+2,4))
            move!(r,Nord)
        else move!(r,direction)
        end
    end
    println(Temperature/cntr)
end