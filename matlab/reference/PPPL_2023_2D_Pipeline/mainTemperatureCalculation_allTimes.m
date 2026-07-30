close all
clear all

T=logspace(2,4,1001); %Defining temperature range



%%%%% N191114-001: 2 ns

tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='191114_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[3 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[800 500]; %[X Y]
smoothPixels=11;
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=10;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
[Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

params=GrabParams_v3(shotSeqPort);

[temperature,error]=extractAverageTemperature(Te(:,:,1),[0 0.5],[0.05 0.05],whereToPlaceMax,params,targetEdge,400)

% plotTempMap(tempLength,Te(:,:,2),400)
% plotTempMap(tempLength,Te(:,:,3),400)
% plotTempMap(tempLength,Te(:,:,4),400)
% plotTempMap(tempLength,Te(:,:,5),400)


%%
tic
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='191114_002_90-124';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
pinholeToUse=[1 1]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[X Y]
smoothPixels=11;
binSize=[2 2]; %Bin Dimenions: [BinX BinY]
floorValue=10;
howToBin="mean";
params=GrabParams_v3(shotSeqPort);
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc

tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];


params=GrabParams_v3(shotSeqPort);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];

plotTempMap(tempLength,Te(:,:,1),1500)



%%


%%%%% N210317-002: 3 & 4 ns
%%%%%3ns
close all
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='210317_002_90-78';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
filterDataLocation='HIPPIE_DATA_ROOT';
smoothPixels=11;
row=2;
col=1;
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500];  %[X Y]
binSize=[5 5]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image

params=GrabParams_v3(shotSeqPort);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];
plotTempMap(tempLength,Te(:,:,1),500)

isolatedRegion=Te(70:110,90:115,1);
figure()
mesh(isolatedRegion)
view(2)
colorbar()
caxis([0 500])
temp=mean(isolatedRegion,"all","omitnan");


%% 4ns
%close all
row=3; %Really good!!!!
col=3;
smoothPixels=5;
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500];  %[X Y]
binSize=[1 1]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);


params=GrabParams_v3(shotSeqPort);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];

plotTempMap(tempLength,Te(:,:,1),1000)

% isolatedRegion=Te(35:100,95:105,1);
% figure()
% mesh(isolatedRegion)
% view(2)
% colorbar()
% caxis([0 1000])
% temp=mean(isolatedRegion,"all","omitnan")



%%
%%%% N201117-004: 5 & 6 ns
close all
clear all

shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='201117_004_90-78';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
filterDataLocation='HIPPIE_DATA_ROOT';

row=2; %smooth 31, but okay otherwise
col=1;
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[row column]
smoothPixels=11;
binSize=[5 5];
floorValue=1;
howToBin="mean";
tempBound=[100 20000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
params=GrabParams_v3(shotSeqPort);

Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];


plotTempMap(tempLength,Te(:,:,1),400)


isolatedRegion=Te(15:80,90:110,1);
figure()
mesh(isolatedRegion)
view(2)
colorbar()
caxis([0 400])
temp=mean(isolatedRegion,"all","omitnan")


%%
close all
row=3; %pretty solid at smoothing of 31 pixels
col=3; 
filterDataLocation='HIPPIE_DATA_ROOT';
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToLook=0;
whereToPlaceMax=[500 500]; %[row column]
smoothPixels=11;
binSize=[5 5];
floorValue=10;
howToBin="mean";
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image


plotTempMap(tempLength,Te(:,:,1),400)


isolatedRegion=Te(35:100,90:110,1);
figure()
mesh(isolatedRegion)
view(2)
colorbar()
caxis([0 400])
temp=mean(isolatedRegion,"all","omitnan")



%%
%%%% N210317-001: 7 & 8 ns
close all
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='210317_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right

params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smoothPixels=11;

row=2; %okay but maybe change the smoothing
col=1;

tic
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[X Y]
smoothPixels=11;
binSize=[5 5]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 20000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image

plotTempMap(tempLength,Te(:,:,1),400)



isolatedRegion=Te(60:115,85:100,1);
figure()
mesh(isolatedRegion)
view(2)
colorbar()
caxis([0 400])
temp=mean(isolatedRegion,"all","omitnan")


%%
close all
row=3; %not bad at all
col=3;
filterDataLocation='HIPPIE_DATA_ROOT';
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
tic
pinholeToUse=[row col]; %[row column] in image configuration with plasma expansion facing down
whereToPlaceMax=[500 500]; %[X Y]
smoothPixels=11;
binSize=[5 5]; %Bin Dimenions: [BinX BinY]
floorValue=1;
howToBin="mean";
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image
Te=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);
toc
tempLength=(max(pixels2RealUnits(1050,params))/(size(Te,1)-1))*[0:size(Te,1)-1];
tempBound=[100 10000]; % tempBound [a b] | all temperature values of a are excluded, and all values > b are exluded from the output temperature image

plotTempMap(tempLength,Te(:,:,1),400)




isolatedRegion=Te(60:110,90:110,1);
figure()
mesh(isolatedRegion)
view(2)
colorbar()
caxis([0 400])
temp=mean(isolatedRegion,"all","omitnan")

