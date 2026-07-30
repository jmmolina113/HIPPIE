function reducedPinhole=binningAlgorithm_v2(pinhole,binX,binY,whatToDo)
%This function is used to downscale a given image by creatined bins of
%size=binSize within the image, averaging all values in each bin, and
%compopsing a new, "reduced", image out of these macro-pixels. 

%% Error condition
if binX==1 && binY==1 %The code only allows bins of even numbered size and will error out otherwise
    reducedPinhole=pinhole;
    return %#ok<*UNRCH> 
end

%% Intialialization of the binning algorithm
%The general approach for this binning algorithm is to somehow define a unit
%cell based off of the user inputs, and to then loop through the image
%and find the mean of the each bin.

%We now construct the dimensions of the new reduced array, and the anchor
%points from which we create our bins
colAnchors=binX:binX:size(pinhole,2); 
rowAnchors=(binY:binY:size(pinhole,2))-1;

%For certian bin sizes and input pinhole dimensions, the grid will not be
%even at the right hand edges. Thus we need to artificially adjust the
%boundaries to make sure we bin all values. 
if rowAnchors(end)~=(size(pinhole,1)-1)

    rowAnchors(length(rowAnchors)+1)=(size(pinhole,1)-1);

end

if colAnchors(end)~=size(pinhole,2)

    colAnchors(length(colAnchors)+1)=colAnchors(end)+binX;

end

%% Created the reduced image
%The following loops will loop through the pinhole image, bin all of the
%appropriate values, and then calculate the mean of said bin as the new
%value of the mega-pixel in the new, reduced, image.

for newRow=1:length(rowAnchors) %Looping over each new row of the reduced pinhole
    for newColumn=1:length(colAnchors) %Looping over each new column of the reduced pinhole

        bin=0; %resetting the bin values
        for i=1:binX %lopping over each column in the bin
            for j=1:binY %lopping over each row in the bin

                colsToUse=(colAnchors(newColumn)-(binX-1)):colAnchors(newColumn); %Identifying which values in the pinhole to bin
                rowsToUse=(rowAnchors(newRow)-(binY-2)):(rowAnchors(newRow)+1); %Identifying which values in the pinhole to bin

                    if (colsToUse(i)>size(pinhole,2)) || (rowsToUse(j)>size(pinhole,1)) %For cases with an uneven grid
                        %we simply place a NaN value in every place that
                        %code wishes to exceed the dimensions of the
                        %pinhole and then omit the nan values when
                        %calculating the mean
    
                        bin(j,i)=NaN;
    
                    else %placing a given value from the pinhole in the bin

                        bin(j,i)=pinhole(rowsToUse(j),colsToUse(i)); %#ok<*AGROW> 

                    end

            end
        end
        
        if whatToDo=="mean"
            reducedPinhole(newRow,newColumn)=mean(bin,"all",'omitnan'); %calculing the mean value of the bin and placing it
        %in the new reduced image
        elseif whatToDo=="median"
            reducedPinhole(newRow,newColumn)=median(bin,"all",'omitnan'); %calculing the median value of the bin and placing it
        %in the new reduced image
        elseif whatToDo=="geomean"
               reducedPinhole(newRow,newColumn)=geomean(bin,"all",'omitnan'); %calculing the median value of the bin and placing it
        %in the new reduced image      
        end

    end
end



end