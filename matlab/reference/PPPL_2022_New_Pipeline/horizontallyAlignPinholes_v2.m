function [alignedPinhole2_h,difference]=horizontallyAlignPinholes_v2(inputPinhole1,inputPinhole2,whereToLook)

%This function will take in two pinholes and horizontally align pinhole 2 wrt
%to Pinhole 1. 

    horizontalLineout1=mean(inputPinhole1(470:530,:),"omitnan"); %Generating lineout through pinhole 1
    horizontalLineout2=mean(inputPinhole2(470:530,:),"omitnan"); %Generating lineout through pinhole 2

    %Depending on the feature we are interested in, the following
    %selection statements will identify the proper region to align to. If
    %we are interested in the plasma plumes themselves then the first
    %clause will kick in, and if we are interested in the current sheet
    %region then the second clause will kick in.

    if (whereToLook==1 || whereToLook==-1)
        
        [~,alignmentPoint1]=min(horizontalLineout1(100:700)); %Isolating alignment point in pinhole 1
        [~,alignmentPoint2]=min(horizontalLineout2(100:700)); %Isolating point to align in pinhole 2

    elseif whereToLook==0
        
        [~,alignmentPoint1]=max(horizontalLineout1(450:550)); %Isolating alignment point in pinhole 1
        [~,alignmentPoint2]=max(horizontalLineout2(450:550)); %Isolating point to align in pinhole 2

    end

    difference=alignmentPoint1-alignmentPoint2; %Calculating difference in alignment points


    imbedLength=500; %How much blank space do we want on both sides of the array? Blank space on each side = imbedLength/2
    imbededSpace=nan(1,size(inputPinhole2,2)+imbedLength); %Creating empty NaN space
    rangeX=(imbedLength/2):((imbedLength/2)-1)+size(inputPinhole2,2); %Creating range for the horizontal values in the data
    rangeY=1:size(inputPinhole2,2); %Creating range for the vertical values in the data
    imbededSpace(rangeY,rangeX)=inputPinhole2; %Imbedding pinhole2 in the empty NaN Space

    alignedPinhole2_h=imbededSpace(rangeY,rangeX-difference); %Applying shift to pinhole 2, aligning it wrt pinhole 1, and outputting the new aligned pinhole 2



    %% vvvvv Uncomment for plots of useful things vvvvv

    phrase=sprintf('Horizontal shift is %d...',difference);
    disp(phrase)
% 
%         figure()
%     plot((1/max(horizontalLineout1(1:600)))*(horizontalLineout1),'b-','LineWidth',2);
%     hold on
%     plot((1/max(horizontalLineout2(1:600)))*(horizontalLineout2),'r-','LineWidth',2);
%     hold on
%     xline(alignmentPoint1+450,'k-','LineWidth',2.5)
%     hold on
%     xline(alignmentPoint2+450,'g-','LineWidth',2.5)
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("Before horizontal alignment")
% 
% 
%     horizontalLineout2_h=mean(alignedPinhole2_h(470:530,:),"omitnan");
% 
%     figure()
%     plot((1/max(horizontalLineout1(10:600)))*(horizontalLineout1),'b-','LineWidth',2);
%     hold on
%     plot((1/max(horizontalLineout2(10:600)))*(horizontalLineout2_h),'r-','LineWidth',2);
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("After horizontal alignment")



end
