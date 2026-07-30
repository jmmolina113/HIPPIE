function [pinhole1Aligned,pinhole2Aligned,netShiftVert,netShiftHorz]=alignPinholes(inputPinhole1,inputPinhole2,whereToLook,averageRange)
    
    iteration=0;
    keepGoing=1;
    netShiftVert=0;
    netShiftHorz=0;
    while (keepGoing~=0)

        iteration=iteration+1;
        
        if (iteration > 10)

            disp("Error: Alignment Not Working")
            return
            
        end

        [pinhole1Aligned,pinhole2Aligned,keepGoing,shiftVert,shiftHorz]=iterativePinholeAlignment(inputPinhole1,inputPinhole2,whereToLook,averageRange);
        inputPinhole2=pinhole2Aligned;

        netShiftVert=netShiftVert+shiftVert;
        netShiftHorz=netShiftHorz+shiftHorz;

    end

    phrase=sprintf('Net horizontal shift was %d...',netShiftHorz);
    disp(phrase)

    phrase=sprintf('Net vertical shift was %d...',netShiftVert);
    disp(phrase)

    phrase=sprintf('Finished after %d iterations!',iteration);
    disp(phrase)

end