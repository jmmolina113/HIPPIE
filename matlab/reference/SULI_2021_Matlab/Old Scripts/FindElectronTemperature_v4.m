close all
clear all

%% Inputs

row=2;
col1=1;
col2=2;
% 
% 
% 
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='191114_002_90-124';

% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='191114_001_90-78';
% 


%% Creating Raw Data and Isolating Pinholes
[RawData,pre_cal]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
post_cal=RawData;
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 
smoothing_type='movmean'; 

where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right
[Final,max_x,max_y,diff_y]=SelectPinhole_Imbedded_v7(RawData,params,col1,row,500,500,smoothing_type,31,where_to_look);
[Final2,max_x2,max_y2,diff_y2]=SelectPinhole_Imbedded_v7(RawData,params,col2,row,500,500,smoothing_type,31,where_to_look);

Range=RealUnits2Pixels(1.5,params);
Avg_Range=RealUnits2Pixels((0.3)/2,params);



%% Creating Lineouts
% Aligned1=smoothdata(Aligned1,'movmean',5);
% Aligned2=smoothdata(Aligned2,'movmean',5);



[Aligned1,Aligned2]=AllignPinholes(Final,Final2,Avg_Range,max_x,max_y,max_x2,max_y2);

[y,x]=FindMax(Aligned1);
[y2,x2]=FindMax(Aligned2);

X_avg=(x-Avg_Range):(x+Avg_Range);

lineout=mean(Aligned1(:,X_avg),2);%Step 1
[~,new_max]=max(lineout); %Step 2
bckgrnd=background(lineout); %Step 3
lineout=lineout(new_max:-1:(new_max-Range));%Step 4
lineout=lineout-bckgrnd; %Step 5
norm=max(lineout);
lineout=(1/norm)*lineout; %Step 6

data=readtable('3umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
D1=data(:,1);
Three_um=data(:,2);

data=readtable('6umCurve.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
D2=data(:,1);
Six_um=data(:,2);

Z=(1.5/Range)*[0:1:Range];

% plot(Z,lineout);
% hold on
% hold on
% plot(D1,Three_um)

Avg_Range=[20:50];
lineout=zeros(size(lineout,1),size(Avg_Range,2));
lineout2=zeros(size(lineout,1),size(Avg_Range,2));

figure()
for i=1:size(Avg_Range,2)

X_avg=(x-Avg_Range(i)):(x+Avg_Range(i));

A=lineout(:,i);
A=mean(Aligned1(:,X_avg),2);%Step 1
[~,new_max]=max(A); %Step 2
bckgrnd=background(A); %Step 3
A=A(new_max:-1:(new_max-Range));%Step 4
A=A-bckgrnd; %Step 5
A=(1/norm)*A; %Step 6
lineout(:,i)=A;

plot(Z,lineout(:,i))
hold on


end

plot(D1,Three_um)

set(gca, 'YScale', 'log')
ylim([0.0001 10])
title('3um filter pinhole')
xlabel('z(mm)')
ylabel('Signal')
legend()
hold off


figure()
for i=1:size(Avg_Range,2)

X_avg=(x-Avg_Range(i)):(x+Avg_Range(i));    
    
A=lineout2(:,i);
A=mean(Aligned2(:,X_avg),2);%Step 1
[~,new_max2]=max(A); %Step 2
bckgrnd=background(A); %Step 3
A=A(new_max2:-1:(new_max2-Range));%Step 4
A=A-bckgrnd; %Step 5
A=(1/norm)*A; %Step 6
lineout2(:,i)=A;

plot(Z,lineout2(:,i))
hold on

end

plot(D2,Six_um)

set(gca, 'YScale', 'log')
ylim([0.0001 10])
title('6um filter pinhole')
xlabel('z(mm)')
ylabel('Signal')
legend()
%legend('My 3um','My 6um','Paper 3um','Paper 6um')
%lineout through x=1812, avg +/-40

    
% lineout2=mean(Aligned2(:,X_avg),2);%Step 1
% [~,new_max2]=max(lineout2); %Step 2
% bckgrnd=background(lineout2); %Step 3
% lineout2=lineout2(new_max2:-1:(new_max2-Range));%Step 4
% lineout2=lineout2-bckgrnd; %Step 5
% lineout2=(1/norm)*lineout2; %Step 6



%% Grabbing Transmission Coefficients 
[E,trans_coeff_3]=GetFilterTransmission('Al_10um.txt',3,0);
[E,trans_coeff_65]=GetFilterTransmission('Al_10um.txt',6.5,0);


%% Defining Physical Parameters
T=logspace(2,4,1001); %Defining temperature range



%% Integration

[Integral_1]=IntegrateTheStuff(E,T,trans_coeff_3); %Pinhole [row,col]=[2,1]
[Integral_2]=IntegrateTheStuff(E,T,trans_coeff_65); %Pinhole [row,col]=[2,2]

R=Integral_2./Integral_1; %Size of 1x101

data=readtable('RealRatioData.csv.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Real_Ratio=data(:,2);
Real_Temps=data(:,1);

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

S_y=lineout2./lineout; %
data=readtable('SignalRatio.xlsx','Format','auto'); %Read in data
data=table2array(data); %Restructure data into something more useful
Z_signal=data(:,1);
Signal_Ratio=data(:,2);

figure()
plot(Z,S_y)
hold on
plot(Z_signal,Signal_Ratio)
hold off
ylabel(' Signal Ratio')
xlabel('z [mm]')
ylim([0 0.4])
xlim([0 1.5])
legend()
hold off

[Electron_Temp,Location_y]=FindTemp(R,mean(S_y),T,params);

Electron_Temp;

M=abs(median(S_y)-median(Signal_Ratio));

figure()
plot(2*Avg_Range,M)
xlabel('Range we average over')
ylabel('Median Signal Ratio')

figure()
plot(2*Avg_Range,Electron_Temp)
xlabel('Range we average over')
ylabel('Electron Temperature')


%%
min(M)


