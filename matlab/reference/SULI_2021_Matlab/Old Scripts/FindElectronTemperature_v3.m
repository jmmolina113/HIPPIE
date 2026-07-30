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

[Aligned1,Aligned2]=AllignPinholes(Final,Final2,50,max_x,max_y,max_x2,max_y2);


%% Creating Lineouts

% 
% [lineout_x,lineout_y]=GenerateLineouts(x,y,100,Aligned1);
% [lineout2_x,lineout2_y]=GenerateLineouts(x2,y2,100,Aligned2);
% 

% 
% lineout_y=mean(Aligned1(:,Range),2);
% 
% normal_x=(1/max(lineout_x(300:600)))*lineout_x;
% normal_y=(1/max(lineout_y(300:600)))*lineout_y;
% 
% normal2_x=(1/max(lineout_x(300:600)))*lineout2_x;
% normal2_y=(1/max(lineout_y(300:600)))*lineout2_y;
% 
% [RawData,pre_cal]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
% post_cal=RawData;
% 
% lineout_manual=mean(RawData(1342:1560,418:518),2);
% lineout_manual=lineout_manual-mean(lineout_manual(1:10));
% lineout_manual=(1/max(lineout_manual))*lineout_manual;


data=readtable('3umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z=data(:,1);
Three_um=data(:,2);

data=readtable('6umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z2=data(:,1);
Six_um=data(:,2);



range=(1.5/175)*[0:1:175];
range4=(1.5/214)*[0:1:214];
range3=(1.88/219)*[219:-1:1];
figure()
%plot(range,normal_y(y:-1:(y-175)))
%hold on
%plot(range,normal2_y(y2:-1:(y2-175)))
%hold on
%plot(range3,lineout_manual)
%hold on
plot(range4,lineout)
hold on
plot(Z,Three_um)
hold on
%plot(Z2,Six_um)
set(gca, 'YScale', 'log')
ylim([0.0001 10])
xlabel('z(mm)')
ylabel('Signal')
legend('My lineout','paper data')


%%
figure()
data=readtable('DereksLineout.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
D1=data(:,1);
D2=data(:,2);

plot(D1,D2)
hold on
plot(lineout)
legend('Real','Mine')
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

% % %S_x=normal2_x./normal_x; %size=1051x1
% % S_y=normal2_y./normal_y; %size=1051x1
% % S_y=S_y((500):-1:(500-175));
% 
% data=readtable('SignalRatio.xlsx','Format','auto'); %Read in data
% data=table2array(data); %Restructure data into something more useful
% Z3=data(:,1);
% Signal_Ratio=data(:,2);
% 
% 
% figure()
% plot(range,S_y)
% hold on
% plot(Z3,Signal_Ratio)
% hold off
% ylabel(' Signal Ratio')
% xlabel('z [mm]')
% ylim([0 0.4])
% xlim([0 1.5])
% legend('My Signal Ratio','Paper Signal Ratio')
% hold off

% %%
% [T_y_Real,Location_y_Real]=FindTemp(Real_Ratio,Signal_Ratio,T,params);
% [T_y,Location_y]=FindTemp(R,mean(S_y),T,params);

data=readtable('DereksLineout.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
D1=data(:,1);
D2=data(:,2);

figure()

lineout=mean(Aligned1(:,418:518),2);
lineout=lineout-mean(lineout(4:14));
lineout=normalize(lineout);


% plot([325:500],normal_y(325:500))
% hold on
% plot(lineout)
hold on
[RawData,pre_cal]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
post_cal=RawData;

lineout_manual=mean(RawData(1342:1560,418:518),2);
lineout_manual=lineout_manual-mean(lineout_manual(1:10));
lineout_manual=(1/max(lineout_manual))*lineout_manual;
range3=[1:1:219];
plot(range3+285,lineout_manual)

hold on
D1=(D1+285);
plot(D1,D2)
hold on
xlim([300 520])
ylim([0.001 5])
set(gca, 'YScale', 'log')
% hold on
% plot(Z,Three_um)
legend('manual lineout across max','automated lineout acorss max','lineout from 1342:1560 in y and averaged from 418-518 in x.','lineout used in paper')


%%


data=readtable('DereksLineout.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
D1=data(:,1);
D2=data(:,2);

[RawData,pre_cal]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
post_cal=RawData;
lineout_manual=mean(RawData(1342:1560,418:518),2);
lineout_manual=lineout_manual-mean(lineout_manual(1:10));
lineout_manual=(1/max(lineout_manual))*lineout_manual;
figure()
plot(flip(lineout_manual))
hold on
plot(D1,D2)
% hold on
% plot(lineout6)
%set(gca, 'YScale', 'log')

legend('My Image','Your Image')


