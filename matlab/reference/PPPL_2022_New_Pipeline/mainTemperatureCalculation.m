close all
clear all

T=logspace(2,4,1001); %Defining temperature range



%%%%% N191114-001: 2 ns

shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='191114_001_90-78';
filterDataLocation='HIPPIE_DATA_ROOT';
whereToLook = 1; %-1 -> left, 0 -> center, 1 -> right
row=3;
col1=1;
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;



Te_2ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)


%%


%%%%% N210317-002: 3 & 4 ns
%%%%%3ns
close all
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='210317_002_90-78';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
filterDataLocation='HIPPIE_DATA_ROOT';
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;

row=3; %Good! Do not change, just need to filter out that one pixel
col1=1;

Te_3ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)


%%4ns
close all
row=3; %Really good!!!!
col1=3;
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;

Te_4ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)


%%
%%%% N201117-004: 5 & 6 ns
close all
shotLocation='HIPPIE_DATA_ROOT';
calLocation='HIPPIE_DATA_ROOT';
shotSeqPort='201117_004_90-78';
whereToLook = 0; %-1 -> left, 0 -> center, 1 -> right
filterDataLocation='HIPPIE_DATA_ROOT';


row=3; %smooth 31, but okay otherwise
col1=1;
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;


Te_5ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)


%%
close all
row=3; %pretty solid at smoothing of 31 pixels
col1=3; 
filterDataLocation='HIPPIE_DATA_ROOT';
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;

Te_6ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)


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
smooth_pixels=11;

row=2; %okay but maybe change the smoothing
col1=1;

Te_7ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)

%%
close all
row=3; %not bad at all
col1=3;
filterDataLocation='HIPPIE_DATA_ROOT';
params=GrabParams_v3(shotSeqPort); %arg(GrabParams)=(ShotDate_ShotSeq,port)
paraRange=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels
smooth_pixels=11;

Te_8ns=EstimateElectronTemperature_v2(shotLocation,calLocation,shotSeqPort,whereToLook,row,col1,filterDataLocation,paraRange,smooth_pixels)







