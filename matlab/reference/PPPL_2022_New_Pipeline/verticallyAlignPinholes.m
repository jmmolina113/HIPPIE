function [alignedPinhole2_hv,difference]=verticallyAlignPinholes(inputPinhole1,inputPinhole2,averageRange)

%This function will take in two pinholes and vertically align pinhole 2 wrt
%to Pinhole 1. 

    warning('off') %I turn off the warning for the fit functions because they flood the command window.

    lineout1=mean(inputPinhole1(:,(500-averageRange):(500+averageRange)),2,"omitnan"); %Generating lineout through pinhole 1
    lineout2=mean(inputPinhole2(:,(500-averageRange):(500+averageRange)),2,"omitnan"); %Generating lineout through pinhole 2

    %% fit functions and align the fits here

    %Below I flip the lineouts when calculating the gradient just to make
    %some of the math easier when it comes to fitting things. The only
    %thing this changes is the sign of the "difference" value calculated in
    %the next section
    
    lineoutToFit1=flip(lineout1); %Flipping lineout
    lineoutToFit2=flip(lineout2); %Flipping lineout
    regionToFit1=lineoutToFit1(1:570); %Isolating the target edge region to fit
    regionToFit2=lineoutToFit2(1:570); %Isolating the target edge region to fit

    pixelSpace=[1:size(regionToFit1)]; %Generating an array corresponding to the number of pixels in lineoutToFit for the input of the fit() function

    nanIndices=isnan(regionToFit2); %Pin pointing which of those values are NaN values.

    fit1=fit(transpose(pixelSpace),regionToFit1,'gauss2'); %Fitting the linout through pinhole 1
    fit2=fit(transpose(pixelSpace(~nanIndices)),regionToFit2(~nanIndices),'gauss2'); %Fitting the linout through pinhole 2

    %% Calculate alignment point and align
    
    [~,alignmentPoint1]=max(gradient(fit1(pixelSpace))); %Calculating the max descending (acending, in the case of a flipped lineout) gradient that is indictive of the target edge
    [~,alignmentPoint2]=max(gradient(fit2(pixelSpace))); %Calculating the max descending (acending, in the case of a flipped lineout) gradient that is indictive of the target edge
    difference=-1*(alignmentPoint1-alignmentPoint2); %Calculating the difference between the two locations found above to see how much to adjust the second lineout by
    % N.B., despite flipping the lineout, we do not need to convert
    % anything into the reference frame of the un-flipped lineout because
    % we are shifitng the data based off of a relative measurement. The
    % sing flip suffices.


    imbedLength=500; %How much blank space do we want on both sides of the array? Blank space on each side = imbedLength/2

    imbededSpace=nan(size(inputPinhole2,1)+imbedLength,size(inputPinhole2,2)); %Creating empty NaN space
    rangeY=(imbedLength/2):((imbedLength/2)-1)+size(inputPinhole2,1); %Creating range for the vertical values in the data
    rangeX=1:size(inputPinhole2,2); %Creating range for the horizontal values in the data

    imbededSpace(rangeY,rangeX)=inputPinhole2; %Imbedding pinhole2 in the empty NaN Space

    %% Spit out data

    alignedPinhole2_hv=imbededSpace(rangeY-difference,rangeX); %Applying shift to pinhole 2, aligning it wrt pinhole 1, and outputting the new aligned pinhole 2


    %% vvvvv Uncomment for plots of useful things vvvvv


    phrase=sprintf('Vertical shift is %d...',difference);
    disp(phrase)
% 
%     nanspace=nan(length(lineout1)+imbedLength,1); %Creating the empty space
%     range=(imbedLength/2):length(lineout1)+((imbedLength/2)-1); %Creating a range to 
%     nanspace(range)=lineout2;  
% 
%     figure()
%     plot(normalize((lineout1)),'b-','LineWidth',2);
%     hold on
%     plot(normalize((lineout2)),'r-','LineWidth',2);
%     legend("pinhole 1","pinhole 2")
%     title("before vertical alignment")


% 
%     [~,realPoint]=min(gradient(lineout1));
%     figure()
%     plot(normalize(lineout1),'b-','LineWidth',1.5)
%     hold on
%     %plot(normalize(lineout2),'r--','LineWidth',1)
%     %hold on
%     plot(normalize(nanspace(range-difference)),'r-','LineWidth',1.5)
%     legend("Lineout 1","Lineout 2")
%     title("after vertical alignment")


end
