close all
clear all

% shot_location='HIPPIE_DATA_ROOT';
% cal_location='HIPPIE_DATA_ROOT';
% shot_seq_port='191114_001_90-78';
% where_to_look = 1; %-1 -> left, 0 -> center, 1 -> right
% row=3;
% col1=1;
% FilterFileName='HIPPIE_DATA_ROOT';
% FilterFileName2='HIPPIE_DATA_ROOT';
% t1=3;
% t2=6.5;


shot_location='HIPPIE_DATA_ROOT';
cal_location='HIPPIE_DATA_ROOT';
shot_seq_port='210317_002_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right
row=4;
col1=3;
FilterFileName='HIPPIE_DATA_ROOT';
FilterFileName2='HIPPIE_DATA_ROOT';
t1=3.22;
t2=3.22;
[Te]=EstimateElectronTemperature_v2(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);



%%
[rawData]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v3(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[pinhole1,max_x,max_y]=SelectPinhole_v2(rawData,col1,row,500,500,smoothType,smoothPixels,where_to_look,1); %Isolating the pinhole of interest
[pinhole2,max_x2,max_y2]=SelectPinhole_v2(rawData,col2,row,500,500,smoothType,smoothPixels,where_to_look,1); %Isolating the second pinhole of interest

%smoothedArray=rawData;
 PlotArray(rawData)
% PlotArray(smoothedArray)

PlotPinhole(pinhole1)
title("Pinhole 1")
PlotPinhole(pinhole2)
title("Pinhole 2 - Before Alignment")


[pinhole1Aligned,pinhole2Aligned]=alignPinholes(pinhole1,pinhole2,where_to_look);

PlotPinhole(pinhole2Aligned)
title("Pinhole 2 - Aligned")


lineout1_full=mean(pinhole1Aligned(:,500-perpRange:500+perpRange),2);
lineout2_full=mean(pinhole2Aligned(:,500-perpRange:500+perpRange),2);



figure()
plot(normalize(lineout1_full),'b-','LineWidth',1.5)
hold on
plot(normalize(lineout2_full),'r-','LineWidth',1.5)
legend("Lineout 1","Lineout 2")
title("Lineouts Prouced by New Code!!!!")



lineout1_extracted=mean(pinhole1Aligned(500:500+paraRange,500-perpRange:500+perpRange),2);
lineout2_extracted=mean(pinhole2Aligned(500:500+paraRange,500-perpRange:500+perpRange),2);

% figure()
% plot((1/max(lineout1_extracted))*(lineout1_extracted),'b-','LineWidth',2.5)
% hold on
% plot((1/max(lineout1_extracted))*(lineout2_extracted),'r-','LineWidth',2.5)
% set(gca,'Yscale','log')










