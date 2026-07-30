function [pinhole1Aligned,pinhole2Aligned,netShiftVert,netShiftHorz,targetEdge]=alignPinholes_2D_v2(inputPinhole1,inputPinhole2,whereToLook,averageRange,maximaCoords)
    %This function is used to go through the entire alignment process for
    %two pinholes

    %% Initialization of the procedure
    iteration=0;
    keepGoing=1;
    netShiftVert=0;
    netShiftHorz=0;
    vertShifts(1)=0; %Net vertical shift applied to pinhole 2
    horzShifts(1)=0; %Net horizontal shift applied to pinhole 2
    stuck=[0,0];
    manualShift=[0,0];


    %% Looping over the alignment process until interativePinholeAlignment.m is no longer able to shift a given pinhole or the iterations exceed a given amount
    while (keepGoing~=0)

        iteration=iteration+1;

        [pinhole1Aligned,pinhole2Aligned,keepGoing,shiftHorz,shiftVert,targetEdge]=iterativePinholeAlignment_2D_v2(inputPinhole1,inputPinhole2,whereToLook,averageRange,maximaCoords,stuck,manualShift);
        inputPinhole2=pinhole2Aligned;
        
        vertShifts(iteration+1)=shiftVert; %Net vertical shift applied to pinhole 2
        horzShifts(iteration+1)=shiftHorz; %Net horizontal shift applied to pinhole 2

        [stuck(1),manualShift(1)]=isStuck(vertShifts);
        [stuck(2),manualShift(2)]=isStuck(horzShifts);

       if (stuck(1) == 2 || stuck(2) == 2)

            error('Alignment Failed')

       end


    end

    netShiftHorz=sum(horzShifts);
    netShiftVert=sum(vertShifts);

end