function floored_lineout=FloorLineout(lineout)

 for i=1:size(lineout,1)

        
        if lineout(i) < 0
            
            lineout(i)=1;
            
        end

 end

 
 floored_lineout=lineout;


end