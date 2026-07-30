function [S_total,didSwitch,targetEdge]=PinholeAnalysis_2D(shotLocation,calLocation,parametersLocation,shotSeqPort,row,col1,col2,smoothingType,smoothPixels,whereToLook,whereToPlaceMax,perpRange,binSize,floorValue,howToBin,params)


%% Creating Raw Data + Isolating Pinholes
[RawData]=MakeProcessedData_v2(shotLocation,calLocation,parametersLocation,shotSeqPort);

PlotArray(RawData)

[pinhole1,~,~]=SelectPinhole_2D(RawData,row,col1,whereToPlaceMax(1),whereToPlaceMax(2),smoothingType,smoothPixels,whereToLook,1); %Isolating the pinhole of interest
[pinhole2,~,~]=SelectPinhole_2D(RawData,row,col2,whereToPlaceMax(1),whereToPlaceMax(2),smoothingType,smoothPixels,whereToLook,1); %Isolating the second pinhole of interest

[pinhole1,pinhole2,didSwitch]=switchPinholes(pinhole1,pinhole2);

%% Down Scaling + Aligning the Pinholes


[pinhole1_aligned,pinhole2_aligned,~,~,targetEdge]=alignPinholes_2D_v2(pinhole1,pinhole2,whereToLook,perpRange,(whereToPlaceMax)); %Aligning both pinholes

pinhole1_final=processPinholes(pinhole1_aligned,whereToPlaceMax,floorValue); %Processing both pinholes
pinhole2_final=processPinholes(pinhole2_aligned,whereToPlaceMax,floorValue);

rangeToCut=[targetEdge]; %Identifying the target edge + a few pixels to produce a clear image

pinhole1_final(rangeToCut:end,:)=nan; %Cutting out vacuum space behind the target
pinhole2_final(rangeToCut:end,:)=nan; %Cutting out vacuum space behind the target

lengthScale_X=pixels2RealUnits([0:length(pinhole1_final)-1]-whereToPlaceMax(2),params);
lengthScale_Y=pixels2RealUnits([0:size(pinhole1_final(1:targetEdge,:),1)-1]-targetEdge,params);


figure()
surf(lengthScale_X,lengthScale_Y,pinhole1_final(1:targetEdge,:))
view(2)
clbr=colorbar;
clbr.Label.String="Signal (Arb)";
caxis([0 1200]);
grid off
shading interp
set(gca,'linewidth',2);
set(gca,'fontsize',24)
xlim([min(lengthScale_X)-0.05 max(lengthScale_X)+.05])
ylim([min(lengthScale_Y)-0.05 max(lengthScale_Y)+.05])
%title("DIM 90-78: 3.22\mum Al Filtered Pinhole, t=4ns");
xlabel("Length [mm]",'FontSize',24)
ylabel("Length [mm]",'FontSize',24)

figure()
surf(lengthScale_X,lengthScale_Y,pinhole2_final(1:targetEdge,:))
view(2)
clbr=colorbar;
clbr.Label.String="Signal (Arb)";
caxis([0 1200]);
grid off
shading interp
set(gca,'linewidth',2);
set(gca,'fontsize',24)
xlim([min(lengthScale_X)-0.05 max(lengthScale_X)+.05])
ylim([min(lengthScale_Y)-0.05 max(lengthScale_Y)+.05])
%title("DIM 90-124: 4.82\mum Al Filtered Pinhole, t=4ns");
xlabel("Length [mm]",'FontSize',24)
ylabel("Length [mm]",'FontSize',24)


%% Processing Pinholes + Constructing the S matrices

S_initial=pinhole2_final./pinhole1_final; %constructing the signal ratio matrix
S=binningAlgorithm_v2(S_initial,binSize(1),binSize(2),howToBin); %Down scaling the signal ratio matrix


errorMatrix=nan(size(pinhole2_final,1)+500,size(pinhole2_final,2)+500);
imbedRange=[1:size(pinhole2_final,1)]+250;

errorMatrix(imbedRange,imbedRange)=pinhole2_final;

errorShift=round(RealUnits2Pixels(0.05,params));

upperErrorBound_h=errorMatrix(imbedRange,imbedRange+errorShift);
lowerErrorBound_h=errorMatrix(imbedRange,imbedRange-errorShift);

upperErrorBound_v=errorMatrix(imbedRange+errorShift,imbedRange);
lowerErrorBound_v=errorMatrix(imbedRange-errorShift,imbedRange);

S_horizontal_upperBound=upperErrorBound_h./pinhole1_final;
S_horizontal_lowerBound=lowerErrorBound_h./pinhole1_final;

S_vertical_upperBound=upperErrorBound_v./pinhole1_final;
S_vertical_lowerBound=lowerErrorBound_v./pinhole1_final;

S_horizontal_upperBound=binningAlgorithm_v2(S_horizontal_upperBound,binSize(1),binSize(2),howToBin); %Down scaling the signal ratio matrix
S_horizontal_lowerBound=binningAlgorithm_v2(S_horizontal_lowerBound,binSize(1),binSize(2),howToBin); %Down scaling the signal ratio matrix

S_vertical_upperBound=binningAlgorithm_v2(S_vertical_upperBound,binSize(1),binSize(2),howToBin); %Down scaling the signal ratio matrix
S_vertical_lowerBound=binningAlgorithm_v2(S_vertical_lowerBound,binSize(1),binSize(2),howToBin); %Down scaling the signal ratio matrix

S_total(:,:,1)=S;
%S_total(:,:,1)=imgaussfilt(S,11);
S_total(:,:,2)=S_horizontal_upperBound;
S_total(:,:,3)=S_horizontal_lowerBound;
S_total(:,:,4)=S_vertical_upperBound;
S_total(:,:,5)=S_vertical_lowerBound;

targetEdge=round(targetEdge*(size(S,1)/size(pinhole1,2))); %rough estimate for how the target edge transforms with down scaling

figure()
surf(lengthScale_X,lengthScale_Y,S_total(1:targetEdge,:,1))
shading interp
clbr=colorbar;
clbr.Label.String="Pinhole Ratio Value";
xlim([min(lengthScale_X)-0.05 max(lengthScale_X)+.05])
ylim([min(lengthScale_Y)-0.05 max(lengthScale_Y)+.05])
view(2)
caxis([0 1]) 
set(gca,'linewidth',2);
set(gca,'fontsize',24)
title("Signal Ratio Matrix")
grid off
xlabel("Length [mm]",'FontSize',24)
ylabel("Length [mm]",'FontSize',24)




end