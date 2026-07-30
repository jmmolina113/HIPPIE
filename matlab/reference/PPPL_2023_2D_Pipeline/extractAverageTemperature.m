function [temperature,error]=extractAverageTemperature(temperatureMap,whereToStartBox,windowDimensions,whereToPlaceMax,params,targetEdge,colorBarLimit)

%% Defining axes of isolation as the intersection of the target edge and the maxima of the feature of interest
horizontalConversion=(size(temperatureMap,2)/1051);
verticalConversion=(size(temperatureMap,1)/1051);

maxCoords=[whereToPlaceMax(1)*horizontalConversion,whereToPlaceMax(2)*verticalConversion]; %[X,Y] or [Column, Row]
maxCoords=(maxCoords);
zeroPoint=[maxCoords(1),targetEdge];

%% Isolating region of interest

startingPoint=round(RealUnits2Pixels(whereToStartBox,params)); %whereToDrawBox is in [mm]
startingPoint=[(horizontalConversion*startingPoint(1))+zeroPoint(1),zeroPoint(2)-(verticalConversion*startingPoint(2))];
boxSize=RealUnits2Pixels(windowDimensions,params); %whereToDrawBox is in [mm]
boxSize=[horizontalConversion*boxSize(2),verticalConversion*boxSize(1)]; %switching the box size convention so that it is of the form [X Y]

pixelsToExtract_x=[-1*round(boxSize(1)/2):1*round(boxSize(1)/2)];
pixelsToExtract_y=[-1*round(boxSize(2)/2):1*round(boxSize(2)/2)];

for i=1:length(pixelsToExtract_x)
    for j=1:length(pixelsToExtract_y)

            box(i,j)=temperatureMap(startingPoint(2)+pixelsToExtract_y(j),startingPoint(1)+pixelsToExtract_x(i));

    end
end


temperatureMap(startingPoint(2)+pixelsToExtract_y,startingPoint(1)+min(pixelsToExtract_x))=nan;
temperatureMap(startingPoint(2)+pixelsToExtract_y,startingPoint(1)+max(pixelsToExtract_x))=nan;


temperatureMap(startingPoint(2)+min(pixelsToExtract_y),pixelsToExtract_x+startingPoint(1))=nan;
temperatureMap(startingPoint(2)+max(pixelsToExtract_y),pixelsToExtract_x+startingPoint(1))=nan;

temperature=mean(box,"all","omitnan");
error=std(box,1,"all");

lengthScale_X=pixels2RealUnits([0:length(temperatureMap)-1]-whereToPlaceMax(1),params);
lengthScale_Y=pixels2RealUnits([0:size(temperatureMap(1:targetEdge,:),1)-1]-targetEdge,params);

figure()
surf(lengthScale_X,lengthScale_Y,temperatureMap(1:targetEdge,:))
view(2)
shading interp
clbr=colorbar;
clbr.Label.String="Temperature (eV)";
xlabel("Length [mm]",'FontSize',24)
ylabel("Length [mm]",'FontSize',24)
xlim([min(lengthScale_X)-0.05 max(lengthScale_X)+.05])
ylim([min(lengthScale_Y)-0.05 max(lengthScale_Y)+.05])
view(2)
caxis([0 colorBarLimit]) %Setting the color bar limits
set(gca,'linewidth',2)
set(gca,'fontsize',24)
title("Temperature Map")
grid off


end