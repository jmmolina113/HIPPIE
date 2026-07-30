close all
clear all

%Suppose we want to plot the 
%%%%% N191114-001: 2 ns

tic
shotLocation=; %Where is the shot data?
calLocation=; %Where is the calibration data?
shotSeqPort=; %shotSeqPort number of the shot you want to look at
filterDataLocation=; %Where is the filer data location?
whereToLook=;  %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[]; %[row column] of pinhole we want to use in image configuration with plasma expansion facing down
whereToPlaceMax=[]; %[X-pixel Y-pixel] (within a 1050 x 1050 pixel image)
%What whereToPlaceMax really just deteremines ABOUT where we will place the
%feature of interest. That is, it determines 
smoothPixels=[];
binSize; %Bin Dimenions: [BinX BinY]
floorValue=; %What is the minimum count that we are going to work with? Everything below this gets thrown out
howToBin; %Options = 
tempBound=[100 10000]; % tempBound [a b] | all temperature values < a are excluded, and all values > b are excluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,400)








