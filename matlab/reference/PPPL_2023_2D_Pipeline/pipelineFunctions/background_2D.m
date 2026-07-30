function background=background_2D(pinhole,maximaCoords)

%This function presents a new way of calculating the background value based
%off the gradient of the signal in a given pinhole

slice=pinhole(:,maximaCoords(2)-50:maximaCoords(2)+50); %isolating a slice in the general region of the maxima

lineout=mean(slice,2); %creating a lineout with the non-nan values
lineout=flip(lineout); %flipping the lineout to make the data easier

indices=isnan(lineout); %picking out the nan values
lineout=lineout(~indices);
gradLineout=abs(gradient(lineout)); %taking the abs of the gradient of the lineout

iteration=1; %initializing the while loop
background=0;

while gradLineout(iteration)<0.2 %values beneath 0.2 appear to be charteristic of the background in the lineout profile

    background(iteration)=lineout(iteration); %keeping values in the lineout that satisfy the controling expression
    iteration=iteration+1; %incrementing the iteration

end

% If for whatever reason the above background subtraction does not work and
% the gradients in the lineout do not comply with the above condition then
% we simply opt to call the first 10 pixels the background of the image
if length(background)==1 

    reducedImageLineout=mean(pinhole,2,"omitnan");
    indicesToOmit=isnan(reducedImageLineout);
    lineoutToUse=flip(reducedImageLineout(~indicesToOmit));
    background=mean(lineoutToUse(1:10));

else

    background=mean(background,"omitnan"); %calculating the total background to subtract off if the first method works out


end

end