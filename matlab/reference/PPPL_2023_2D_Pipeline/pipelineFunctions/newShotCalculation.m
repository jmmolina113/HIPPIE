%% N220223-001 1.5ns

close all
clear all

tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[2 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y]
smoothPixels=21;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

%[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.15],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)
[temperature,error]=extractAverageTemperature(Te(:,:,1),[-1.10 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)


%% N220223-001 3.5ns

close all
clear all

tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[2 3]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[X Y]
smoothPixels=21;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0.05 0.15],[0.05 0.05],whereToPlaceMax,params,targetEdge,1500)

%% N220223-003 2.5ns
clear all
close all


tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_003_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[3 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y]
smoothPixels=21;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

%[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.15],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)
[temperature,error]=extractAverageTemperature(Te(:,:,1),[-1.15 0.50],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)

%% N220223-003 4.5ns no bueno
clear all
close all


tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_003_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[2 3]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[X Y]
smoothPixels=21;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,400)

%% N220223-004 1.5ns

clear all
close all

tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
%calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_004_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[2 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y]
smoothPixels=21;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

%[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.15],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)
[temperature,error]=extractAverageTemperature(Te(:,:,1),[-1.10 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,1000)

%% N220223-004 5.5ns no bueno

clear all
close all

tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='220223_004_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[2 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y]
smoothPixels=11;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,400)

%%
figure()
plot([1.5, 2.5, 3.5],[1.2159e+03,723.0714,279.3266],'rs--','LineWidth',2,'MarkerSize',15)
hold on
plot([1.5, 2.5, 3.5],[770.5144,723.0714,279.3266],'bs--','LineWidth',2,'MarkerSize',15)
xlabel('Time [ns]','FontSize',24)
ylabel('Temperature [eV]','FontSize',24)
title('Temp vs Time for 2022 Shots')
xlim([0 4])
set(gca,'fontsize',24)

