% close all
clear all

%% Inputs
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='191114_002_90-124';
smoothing_type='movmean'; 

%smoothing_type='rloess'; %Robust quadratic regression
%smoothing_type='loess'; %Quadratic regression

%smoothing_type='rlowess'; %Robust linear regression
%smoothing_type='lowess'; %Linear regression


row=2;
col1=1;
col2=2;

data=readtable('RealRatioData.csv.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Real_Ratio=data(:,2);
Real_Temps=data(:,1);

% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='191114_001_90-78';



%% Creating Raw Data and Isolating Pinholes
[RawData,pre_cal]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
post_cal=RawData;
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Final,max_x,max_y,Final_b,diff_y]=SelectPinhole_Imbedded_v6(RawData,params,col1,row,500,500,smoothing_type,31);
[Final2,max_x2,max_y2,Final_b2,diff_y2]=SelectPinhole_Imbedded_v6(RawData,params,col2,row,500,500,smoothing_type,31);

[Aligned1,Aligned2]=AllignPinholes(Final,Final2,50);

%% Creating Lineouts
[lineout_x,lineout_y]=GenerateLineouts(max_x,max_y,50,Aligned1);
[lineout2_x,lineout2_y]=GenerateLineouts(max_x2,max_y2,50,Aligned2);

normal_x=(1/max(lineout_x(300:600)))*lineout_x;
normal_y=(1/max(lineout_y(300:600)))*lineout_y;

normal2_x=(1/max(lineout_x(300:600)))*lineout2_x;
normal2_y=(1/max(lineout_y(300:600)))*lineout2_y;



data=readtable('3umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z=data(:,1);
Three_um=data(:,2);

data=readtable('6umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z2=data(:,1);
Six_um=data(:,2);


range=(1.5/175)*[0:1:175];
figure()
plot(range,normal_y((500):-1:(500-175)))
hold on
plot(range,normal2_y((500):-1:(500-175)))
hold on
plot(Z,Three_um)
hold on
plot(Z2,Six_um)
set(gca, 'YScale', 'log')
ylim([0.0001 10])
xlim([0 1.5])
xlabel('z(mm)')
ylabel('Signal')
eval(['legend("[' char(string(row)) ',' char(string(col1)) '] - 3um Al Filter","[' char(string(row)) ',' char(string(col2)) '] - 6um Al Filter","3um From Paper","6um From Paper")'])






% figure()
% plot(normal_x)
% hold on
% plot(normal2_x)
% hold off
% 
% figure()
% plot(normal_y)
% hold on
% plot(normal2_y)
% hold off

% y_depth=RealUnits2Pixels(1.5); %Range to average over from the max
% x_width=RealUnits2Pixels(0.15);



%% Grabbing Transmission Coefficients 
[E,trans_coeff_3]=GetFilterTransmission('Al_10um.txt',3,0);
[E,trans_coeff_65]=GetFilterTransmission('Al_10um.txt',6.5,0);


%% Defining Physical Parameters
T=logspace(2,4,1001); %Defining temperature range
%n=;


%% Integration

[Integral_1]=IntegrateTheStuff(E,T,trans_coeff_3); %Pinhole [row,col]=[2,1]
[Integral_2]=IntegrateTheStuff(E,T,trans_coeff_65); %Pinhole [row,col]=[2,2]

R=Integral_2./Integral_1; %Size of 1x101

figure()
plot(T,R)
hold on
plot(Real_Temps,Real_Ratio)
hold off
ylabel('Ratio')
xlabel('T')
xlim([100 1000])
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
ylim([0.005 1])
legend('My Ratio','Ratio from Paper')
hold off

%% Lineout Comparison

%S_x=normal2_x./normal_x; %size=1051x1
S_y=normal2_y./normal_y; %size=1051x1
S_y=S_y((500):-1:(500-175));

data=readtable('SignalRatio.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z3=data(:,1);
Signal_Ratio=data(:,2);


figure()
plot(range,S_y)
hold on
plot(Z3,Signal_Ratio)
hold off
ylabel(' Signal Ratio')
xlabel('z [mm]')
ylim([0 0.4])
xlim([0 1.5])
legend('My Signal Ratio','Paper Signal Ratio')
hold off


% space_x=params.ccd_xwidth/((size(lineout1_x,1))*4)*[1:1:size(lineout1_x)];
% space_y=params.ccd_xwidth/((size(lineout1_y,1))*4)*[1:1:size(lineout1_y)];

%%
[T_y_Real,Location_y_Real]=FindTemp(Real_Ratio,Signal_Ratio,T,params);
[T_y,Location_y]=FindTemp(R,mean(S_y),T,params);


% %%
% 
% close all
% 
% x=[1:1051];
% y=[1050:2100];
% % pre_cal=pre_cal(y,x);
% % RawData=RawData(y,x);
% 
% range=(1.5/175)*[0:1:175];
% [~,lineout_y]=GenerateLineouts(max_x,max_y-diff_y,50,pre_cal); %Pre-Cal
% [~,lineout_y2]=GenerateLineouts(max_x,max_y-diff_y,50,RawData); %Post-Cal
% [~,lineout_y4]=GenerateLineouts(max_x,max_y,50,Final); %Smoothed, Max-Aligned
% [~,lineout_y3]=GenerateLineouts(max_x,max_y,50,Aligned1); %Area-Aligned
% 
% 
% 
% lineout_y=normalize(lineout_y);
% lineout_y2=normalize(lineout_y2);
% lineout_y3=normalize(lineout_y3);
% lineout_y4=normalize(lineout_y4);
% 
% 
% [~,location]=max(lineout_y(300:600));
% [~,location2]=max(lineout_y2(300:600));
% [~,location3]=max(lineout_y3(300:600));
% [~,location4]=max(lineout_y4(300:600));
% 
% location=location+299;
% location2=location2+299;
% location3=location3+299;
% location4=location4+299;
% 
% % figure()
% % plot(range,lineout_y((location):-1:(location-175)))
% % hold on
% % plot(range,lineout_y2((location2):-1:(location2-175)))
% % hold on
% % plot(range,lineout_y3((location3):-1:(location3-175)))
% % hold on
% % plot(range,lineout_y4((location4):-1:(location4-175)))
% % hold on
% % plot(Z,Three_um)
% % legend('Pre-Calibration','Post-Calibration, Pre-Smooth','Post-Smooth + Max Aligned','Area-Aligned','Paper Data for 3um')
% % 
% data=readtable('DereksLineout.xlsx','Format','auto'); %Read in data
% data=table2array(data); %Restructure data into something more useful
% D1=data(:,1);
% D2=data(:,2);
% %D2=(1/(max(D2)))*(D2);
% 
% 
% 
% figure()
% plot(lineout_y)
% hold on
% plot(lineout_y2)
% hold on
% plot(lineout_y3)
% hold on
% plot(lineout_y4)
% hold on
% plot(D1,D2)
% % hold on
% % plot(Z,Three_um)
% legend('Pre-Calibration','Post-Calibration, Pre-Smooth','Post-Smooth + Max Aligned','Area-Aligned','Paper Data for 3um','Profile you just sent')

%%
% close all
% smoothing='rlowess';
% Smooth=smoothdata(RawData,smoothing,11);
% lineout5=mean(Smooth(1342:1560,418:518),2);
% % lineout5=mean(RawData(1342:1560,418:518),2);
% lineout5=lineout5-mean(lineout5(1:10));
% lineout5=(1/max(lineout5))*lineout5;
% %lineout6=mean(Smooth(1200:1700,500:600),2);
% figure()
% plot(lineout5)
% hold on
% plot(D1,D2)
% % hold on
% % plot(lineout6)
% legend('My Image','Your Image')


