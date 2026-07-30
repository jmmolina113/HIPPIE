function filteredRatio=filterSignalRatio(signalRatio)
%This function is used to filter out all the vaccum pixels from the signal
%ratio before we output it to calculate the electron temperature in the
%given region

    for i=1:size(signalRatio,1)
        for j=1:size(signalRatio,2)

            if signalRatio(i,j)>1
                signalRatio(i,j)=NaN;
            end
            

        end
    end

    filteredRatio=signalRatio;


end