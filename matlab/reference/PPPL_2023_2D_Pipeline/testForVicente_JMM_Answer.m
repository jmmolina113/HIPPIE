clc
close all
clear all

%%%%% N191114-001: 2 ns

tic
parametersLocation='HIPPIE_DATA_ROOT';
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='191114_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right (rarely ever go with -1 but its an option...)
pinholeToUse=[3 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y] (within a 1050 x 1050 pixel image)
%All that ^^^ does is determine the general global position of the final
%image - that is, it just chooses where to put the feature of interest so
%we get a good view of the plasma
smoothPixels=11; %How many pixels to smooth over for fitting purposes.
%Increase that ^^ if the alignment doesn't work too well
binSize=[1 1]; %Bin Dimenions: [BinX BinY]. How big of a bin to use if you
%choose to bin the image. [BinX BinY] = [1 1] means no binning
howToBin="mean"; %How to average the values in the binning algorithm
floorValue=10; %Minimum count to keep in all of our images
tempBound=[100 10000]; % tempBound [a b] 
%all temperature values less than a and greater than b are excluded
%from the output temperature image. This parameter isn't super crucial and
%can be removed form the pipeline without any problems at all

[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,parametersLocation,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc



%Plotting everything 

params=GrabParams_v4(shotSeqPort,parametersLocation);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,400)








