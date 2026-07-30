function [Electron_Temp,lineout,lineout2,S_y,Final,Final2,R]=FindElectronTemperature_v6(shot_location,cal_location,shot_seq_port,row,col1,col2,smoothing_type,smooth_pixels,where_to_look,Avg_Range)


%% Creating Raw Data and Isolating Pinholes
[RawData,~]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Final,max_x,max_y,~]=SelectPinhole_Imbedded_v7(RawData,params,col1,row,500,500,smoothing_type,smooth_pixels,where_to_look,1);
[Final2,max_x2,max_y2,~]=SelectPinhole_Imbedded_v7(RawData,params,col2,row,500,500,smoothing_type,smooth_pixels,where_to_look,1);

Range=RealUnits2Pixels(1.5,params);

Z=(1.5/Range)*[0:1:Range]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[~,Lineout_Y]=AllignPinholes_v2(Final,Final2,Avg_Range,max_x,max_y,max_x2,max_y2);


%% Creating Lineouts

lineout=Lineout_Y(:,1);
lineout2=Lineout_Y(:,2);
[full_lineout,full_lineout2]=GenerateLineouts_v2(lineout,lineout2,4,Range);

lineout=full_lineout(:,2);
lineout2=full_lineout2(:,2);


% [~,new_max]=max(lineout);
% bckgrnd=background(lineout); %Step 3
% lineout=lineout(new_max:-1:(new_max-Range));%Step 4
% lineout=lineout-bckgrnd; %Step 5
% lineout=FloorLineout(lineout);
% norm=max(lineout);
% lineout=(1/norm)*lineout; %Step 6
% 
% 
% bckgrnd=background(lineout2); %Step 3
% lineout2=lineout2(new_max:-1:(new_max-Range));%Step 4
% lineout2=lineout2-bckgrnd; %Step 5
% lineout2=FloorLineout(lineout2);
% lineout2=(1/norm)*lineout2; %Step 6


%[lineout,lineout2]=CurveFitting(Z,lineout,lineout2);

%% Grabbing Transmission Coefficients 
[~,T_1]=GetFilterTransmission('Al_10um.txt',3,0.1);
[E,T_2]=GetFilterTransmission('Al_10um.txt',6.5,0.1);
%  T=[upper_T new_trans_coeff lower_T];
T_1_U=T_1(:,1);
T_1_N=T_1(:,2);
T_1_L=T_1(:,3);

T_2_U=T_2(:,1);
T_2_N=T_2(:,2);
T_2_L=T_2(:,3);

%% Defining Physical Parameters
T=logspace(2,4,1001); %Defining temperature range


%% Integration

[Integral_1_U]=IntegrateTheStuff(E,T,T_1_U); %Pinhole [row,col]=[2,1]
[Integral_2_U]=IntegrateTheStuff(E,T,T_2_U); %Pinhole [row,col]=[2,2]

[Integral_1_N]=IntegrateTheStuff(E,T,T_1_N); %Pinhole [row,col]=[2,1]
[Integral_2_N]=IntegrateTheStuff(E,T,T_2_N); %Pinhole [row,col]=[2,2]

[Integral_1_L]=IntegrateTheStuff(E,T,T_1_L); %Pinhole [row,col]=[2,1]
[Integral_2_L]=IntegrateTheStuff(E,T,T_2_L); %Pinhole [row,col]=[2,2]


R_U=Integral_2_U./Integral_1_U; %Size of 1x101
R_N=Integral_2_N./Integral_1_N; %Size of 1x101
R_L=Integral_2_L./Integral_1_L; %Size of 1x101

R=[R_U R_N R_L];


%% Lineout Comparison
S_y=lineout2./lineout; %
%S_y=smoothdata(S_y,'movmean',smooth_pixels)

%%
Electron_Temp=zeros(307,1);
[Electron_Temp(1),~]=FindTemp(R(:,2),mean(S_y),T,params);



end