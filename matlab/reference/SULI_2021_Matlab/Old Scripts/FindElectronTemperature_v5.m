function [Electron_Temp]=FindElectronTemperature_v5(shot_location,cal_location,shot_seq_port,row,col1,col2,smoothing_type,where_to_look,Avg_Range)


%% Creating Raw Data and Isolating Pinholes
[RawData,~]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Final,max_x,max_y,~]=SelectPinhole_Imbedded_v7(RawData,params,col1,row,500,500,smoothing_type,31,where_to_look);
[Final2,max_x2,max_y2,~]=SelectPinhole_Imbedded_v7(RawData,params,col2,row,500,500,smoothing_type,31,where_to_look);

Range=RealUnits2Pixels(1.5,params);


[Aligned1,Aligned2]=AllignPinholes(Final,Final2,Avg_Range,max_x,max_y,max_x2,max_y2);


%% Creating Lineouts
% Aligned1=smoothdata(Aligned1,'movmean',5);
% Aligned2=smoothdata(Aligned2,'movmean',5);


[~,x]=FindMax(Aligned1);
[~,x2]=FindMax(Aligned2);

X_avg=(x2-Avg_Range):(x2+Avg_Range);

lineout=mean(Aligned1(:,X_avg),2);%Step 1
[~,new_max]=max(lineout); %Step 2
bckgrnd=background(lineout); %Step 3
lineout=lineout(new_max:-1:(new_max-Range));%Step 4
lineout=lineout-bckgrnd; %Step 5
norm=max(lineout);
lineout=(1/norm)*lineout; %Step 6


X_avg=(x2-Avg_Range):(x2+Avg_Range);

lineout2=mean(Aligned2(:,X_avg),2);%Step 1
[~,new_max2]=max(lineout2); %Step 2
bckgrnd=background(lineout2); %Step 3
lineout2=lineout2(new_max2:-1:(new_max2-Range));%Step 4
lineout2=lineout2-bckgrnd; %Step 5
lineout2=(1/norm)*lineout2; %Step 6

%% Grabbing Transmission Coefficients 
[~,trans_coeff_3]=GetFilterTransmission('Al_10um.txt',3,0);
[E,trans_coeff_65]=GetFilterTransmission('Al_10um.txt',6.5,0);

%% Defining Physical Parameters
T=logspace(2,4,1001); %Defining temperature range


%% Integration

[Integral_1]=IntegrateTheStuff(E,T,trans_coeff_3); %Pinhole [row,col]=[2,1]
[Integral_2]=IntegrateTheStuff(E,T,trans_coeff_65); %Pinhole [row,col]=[2,2]

R=Integral_2./Integral_1; %Size of 1x101

%% Lineout Comparison
S_y=lineout2./lineout; %

%%
[Electron_Temp,~]=FindTemp(R,mean(S_y),T,params);




end