function [answer,manualShift]=isStuck(arrayOfShifts)
%This function simply accepts an array of shifts produced by a given
%iteration of alignment and attempts to determine if the alignment
%algorithm is stuck

if length(arrayOfShifts) < 20

    %Let it go for 20 iterations and then check
    answer=0;
    manualShift=0;
    return

else

    sumOfPreviousShifts=sum(arrayOfShifts(end-2:end));



    if sumOfPreviousShifts <= 20 %Way of seeing if its circling around the correct answer

        previousIterations=arrayOfShifts(end-2:end);
    
        answer=1;

        %manualShift = abs(0.5*(max(previousIterations)+min(previousIterations))); %Option 1:
        %Midrange mean

        manualShift=prod(abs(previousIterations))^(1/length(previousIterations)); %Option 2: ~geometric mean
        manualShift=round(manualShift/2);

        if arrayOfShifts(end) > 0
            manualShift=-1*manualShift;
        end

      

    elseif sumOfPreviousShifts > 20 %Way of seeing if its circling around the correct answer

        answer=2;
        manualShift=0;

    end
    

end







end