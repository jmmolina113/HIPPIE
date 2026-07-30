
close all

shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='191114_002_90-124';


% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='191114_001_90-78';


%%Old Shots 
% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
% shot_seq_port='210317_002_90-124';

% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='210317_002_90-78';


RawData=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

%smoothing_type='rloess'; %Robust quadratic regression
%smoothing_type='loess'; %Quadratic regression

%smoothing_type='rlowess'; %Robust linear regression
%smoothing_type='lowess'; %Linear regression

%smoothing_type='gaussian'; %Guassian-weighted moving average
smoothing_type='movmean'; %Moving average
%smoothing_type='movmedian'; %Moving average
%smoothing_type='sgolay'; % Savitzky-Golay filter, which smooths according to a quadratic polynomial that is fitted over each window of A. 


% figure()
% mesh(RawData)
% view(2)
% caxis([0 1500])

row=1;
col1=1;
col2=2;


[Final,max_y,max_x]=SelectPinhole_Imbedded_v5(RawData,params,col1,row,500,500,smoothing_type,31);
[Final2,max_y2,max_x2]=SelectPinhole_Imbedded_v5(RawData,params,col2,row,500,500,smoothing_type,31);

% figure()
% mesh(Final)
% colorbar
% caxis([0 1500]) %Setting the color bar limits
% view(2)
% title('Pinhole [Col,Row]=[3,3]')
% eval(['title("[Row,Col]=[' char(string(row)) ',' char(string(col1)) ']")'])
% 
% figure()
% mesh(Final2)
% colorbar
% caxis([0 1500]) %Setting the color bar limits
% xlim([0 1051])
% ylim([0 1051])
% view(2)
% eval(['title("[Row,Col]=[' char(string(row)) ',' char(string(col2)) ']")'])

%% Method 1


[lineout_x,lineout_y]=MaxAlignLineouts(max_x,max_y,500,500,10,Final);
[lineout_x2,lineout_y2]=MaxAlignLineouts(max_x2,max_y,500,500,10,Final2);

[lineout_x,lineout_x2]=AlignArea(lineout_x,lineout_x2);
[lineout_y,lineout_y2]=AlignArea(lineout_y,lineout_y2);


normal_x=(1/max(lineout_x(300:600)))*lineout_x;
normal_y=(1/max(lineout_y(300:600)))*lineout_y;

normal2_x=(1/max(lineout_x2(300:600)))*lineout_x2;
normal2_y=(1/max(lineout_y2(300:600)))*lineout_y2;

figure()
plot([1:1051],normal_y)
hold on
plot([1:1051],normal2_y)
hold off
xlim([0 1051])
ylim([0.0001 1.2])
set(gca, 'YScale', 'log')
title('Vertical Max Lineout - Normalized')

%eval(['title("Vertical Max Lineout - Normalized: [Row,Col]=[' char(string(row)) ',' char(string(col2)) ']")'])

eval(['legend("[' char(string(row)) ',' char(string(col1)) ']","[' char(string(row)) ',' char(string(col2)) ']")'])
%legend('[char(string(row1)),char(string(col1))]','[char(string(row2)),char(string(col2))]')

% figure()
% plot([1:1051],normal_x)
% hold on
% plot([1:1051],normal2_x)
% hold off
% xlim([0 1051])
% ylim([0 1.2])
% title('Horizontal Max Lineout - Normalized')
%eval(['title("Vertical Max Lineout - Normalized: [Row,Col]=[' char(string(row)) ',' char(string(col2)) ']")'])

eval(['legend("[' char(string(row)) ',' char(string(col1)) ']","[' char(string(row)) ',' char(string(col2)) ']")'])


%% Method 2
% 
% 
% 
% [Aligned1,Aligned2]=AllignPinholes(Final,Final2,10);
% 
% [lineout_x,lineout_y]=GenerateLineouts(max_x,max_y,10,Aligned1);
% [lineout_x2,lineout_y2]=GenerateLineouts(max_x2,max_y2,10,Aligned2);
% 
% 
% normal_x=(1/max(lineout_x(300:600)))*lineout_x;
% normal_y=(1/max(lineout_y(300:600)))*lineout_y;
% 
% normal2_x=(1/max(lineout_x2(300:600)))*lineout_x2;
% normal2_y=(1/max(lineout_y2(300:600)))*lineout_y2;
% 
% figure()
% plot([1:1051],normal_y)
% hold on
% plot([1:1051],normal2_y)
% hold off
% xlim([0 1051])
% ylim([-0.2 1.2])
% title('Vertical Max Lineout - Normalized')
% 
% %eval(['title("Vertical Max Lineout - Normalized: [Row,Col]=[' char(string(row)) ',' char(string(col2)) ']")'])
% 
% eval(['legend("[' char(string(row)) ',' char(string(col1)) ']","[' char(string(row)) ',' char(string(col2)) ']")'])
% %legend('[char(string(row1)),char(string(col1))]','[char(string(row2)),char(string(col2))]')
% 
% figure()
% plot([1:1051],normal_x)
% hold on
% plot([1:1051],normal2_x)
% hold off
% xlim([0 1051])
% ylim([0 1.2])
% title('Horizontal Max Lineout - Normalized')
% %eval(['title("Vertical Max Lineout - Normalized: [Row,Col]=[' char(string(row)) ',' char(string(col2)) ']")'])
% 
% eval(['legend("[' char(string(row)) ',' char(string(col1)) ']","[' char(string(row)) ',' char(string(col2)) ']")'])
% 
% 

%%

