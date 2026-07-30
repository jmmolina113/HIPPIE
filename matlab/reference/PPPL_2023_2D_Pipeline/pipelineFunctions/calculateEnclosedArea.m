function area=calculateEnclosedArea(lineout1,lineout2)
    
    difference=abs((lineout1)-(lineout2));

    result=0;
    upperIndex=500;
    while result~=1
        
        upperIndex=upperIndex+1;
        result=isnan(difference(upperIndex));
        if upperIndex==1051
            result=1;
        end
        
    end

    result=0;
    lowerIndex=500;
    while result~=1
        
        lowerIndex=lowerIndex-1;
        result=isnan(difference(lowerIndex));
        if lowerIndex==1
            result=1;
        end
        
    end


    area=abs(trapz(difference(lowerIndex+1:upperIndex-1)));

end