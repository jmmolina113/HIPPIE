function [alignedPinhole2_h,difference]=horizontallyAlignPinholes_2D_v2(inputPinhole1,inputPinhole2,whereToLook,horzMax,vertMax,stuck,manualShift)

%This function will take in two pinholes and horizontally align pinhole 2 wrt
%to Pinhole 1.

    horizontalLineout1=mean(inputPinhole1(vertMax-30:vertMax+30,:),"omitnan"); %Generating lineout through pinhole 1
    horizontalLineout2=mean(inputPinhole2(vertMax-30:vertMax+30,:),"omitnan"); %Generating lineout through pinhole 2

    %Depending on the feature we are interested in, the following
    %selection statements will identify the proper region to align to. If
    %we are interested in the plasma plumes themselves then the first
    %clause will kick in, and if we are interested in the current sheet
    %region then the second clause will kick in.

    if (whereToLook==1 || whereToLook==-1)
        
        grad_lineout1=(gradient(horizontalLineout1(horzMax:end)));
        grad_lineout2=(gradient(horizontalLineout2(horzMax:end)));

        [~,alignmentPoint1]=min(grad_lineout1); %Isolating alignment point in pinhole 1
        [~,alignmentPoint2]=min(grad_lineout2); %Isolating point to align in pinhole 2

    elseif whereToLook==0

        grad_lineout1=(gradient(horizontalLineout1(horzMax-25:horzMax+25)));
        grad_lineout2=(gradient(horizontalLineout2(horzMax-25:horzMax+25)));

       [~,alignmentPoint1]=min(abs(grad_lineout1)); %Isolating alignment point in pinhole 1
        [~,alignmentPoint2]=min(abs(grad_lineout2)); %Isolating point to align in pinhole 2

    end

    if stuck == 0 

        difference=alignmentPoint1-alignmentPoint2; %Calculating difference in alignment points

    elseif stuck == 1

       difference=manualShift;

    end



    imbedLength=500; %How much blank space do we want on both sides of the array? Blank space on each side = imbedLength/2
    imbededSpace=nan(size(inputPinhole2,1)+imbedLength,size(inputPinhole2,2)+imbedLength); %Creating empty NaN space
    rangeX=(imbedLength/2):((imbedLength/2)-1)+size(inputPinhole2,2); %Creating range for the horizontal values in the data
    rangeY=1:size(inputPinhole2,2); %Creating range for the vertical values in the data
    imbededSpace(rangeY,rangeX)=inputPinhole2; %Imbedding pinhole2 in the empty NaN Space

    alignedPinhole2_h=imbededSpace(rangeY,rangeX-difference); %Applying shift to pinhole 2, aligning it wrt pinhole 1, and outputting the new aligned pinhole 2



    %% vvvvv Uncomment for plots of useful things vvvvv

%     phrase=sprintf('Horizontal shift is %d...',difference);
%     disp(phrase)

%         figure()
%     plot((1/max(horizontalLineout1(1:250)))*(horizontalLineout1),'b-','LineWidth',2);
%     hold on
%     plot((1/max(horizontalLineout2(1:250)))*(horizontalLineout2),'r-','LineWidth',2);
%     hold on
%     xline(alignmentPoint1+450,'k-','LineWidth',2.5)
%     hold on
%     xline(alignmentPoint2+450,'g-','LineWidth',2.5)
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("Before horizontal alignment")
% 
% 
%     horizontalLineout2_h=mean(alignedPinhole2_h(250:300,:),"omitnan");
% 
%     figure()
%     plot((1/max(horizontalLineout1(10:250)))*(horizontalLineout1),'b-','LineWidth',2);
%     hold on
%     plot((1/max(horizontalLineout2(10:250)))*(horizontalLineout2_h),'r-','LineWidth',2);
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("After horizontal alignment")
% 
%         figure()
%     plot(normalize_v2(horizontalLineout1,whereToLook),'b-','LineWidth',2);
%     hold on
%     plot(normalize_v2(horizontalLineout2,whereToLook),'r-','LineWidth',2);
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("Before horizontal alignment")
% 
%     space=nan(length(horizontalLineout2)+500,1);
%     range=[250:length(horizontalLineout2)+249];
%     space(range)=normalize_v2(horizontalLineout2,whereToLook);
% 
%     figure()
%     plot(normalize_v2(horizontalLineout1,whereToLook),'b-','LineWidth',2);
%     hold on
%     plot(space(range-difference),'r-','LineWidth',2);
%     legend("pinhole 1","pinhole 2")
%     xlim([0 700])
%     title("After horizontal alignment")
    


end
