function Te=calculateTemperature(R,S,tempBound)

T=logspace(2,4,1001); %Defining temperature range

for i=1:size(S,1)
    for j=1:size(S,2)
    
        [Te(i,j)]=FindTemp(R,S(i,j),T); %Finding the electron temperature
        
        if (Te(i,j)==tempBound(1)) || (Te(i,j)>tempBound(2)) %Excluding the floor value of tempBound(1) and values greater than tempBound(2)
            Te(i,j)=nan;
        end
    
     end
    
 end



end
