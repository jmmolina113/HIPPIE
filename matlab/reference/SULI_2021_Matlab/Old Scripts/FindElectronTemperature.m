close all
clear all

%% Inputs
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='191114_002_90-124';
smoothing_type='movmean'; 
row=2;
col1=1;
col2=2;

% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='191114_001_90-78';



%% Creating Raw Data and Isolating Pinholes
RawData=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Fina1]=SelectPinhole_Imbedded_v5(RawData,params,col1,row,500,500,smoothing_type,31);
[Final2]=SelectPinhole_Imbedded_v5(RawData,params,col2,row,500,500,smoothing_type,31);


%% Creating Lineouts
[lineout1_x,lineout1_y]=GenerateLineouts(500,500,500,500,10,Final);
[lineout2_x,lineout2_y]=GenerateLineouts(500,500,500,500,10,Final2);

[lineout1_x,lineout2_x]=AlignArea(lineout1_x,lineout2_x);
[lineout1_y,lineout2_y]=AlignArea(lineout1_y,lineout2_y);



%% Grabbing Transmission Coefficients 
[E,trans_coeff_3]=GetFilterTransmission('Al_10um.txt',3,0);
[E,trans_coeff_65]=GetFilterTransmission('Al_10um.txt',6.5,0);


%% Defining Physical Parameters
T=logspace(2,4,101); %Defining temperature range
%n=;


%% Integration

[Integral_1]=IntegrateTheStuff(E,T,trans_coeff_3); %Pinhole [row,col]=[2,1]
[Integral_2]=IntegrateTheStuff(E,T,trans_coeff_65); %Pinhole [row,col]=[2,2]

R=Integral_1./Integral_2; %Size of 1x101

%% Lineout Comparison

S_x=lineout1_x./lineout2_x; %size=1051x1
S_y=lineout1_y./lineout2_y; %size=1051x1
% space_x=params.ccd_xwidth/((size(lineout1_x,1))*4)*[1:1:size(lineout1_x)];
% space_y=params.ccd_xwidth/((size(lineout1_y,1))*4)*[1:1:size(lineout1_y)];

%%
[T_x,Location_x]=FindTemp(R,S_x,T,params);
[T_y,Location_y]=FindTemp(R,S_y,T,params);





