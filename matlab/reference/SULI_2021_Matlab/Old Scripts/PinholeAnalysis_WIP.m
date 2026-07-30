function [lineout,lineout2,S,A,B,R,G,RawData]=PinholeAnalysis_WIP(shot_location,cal_location,shot_seq_port,row,col1,col2,smoothing_type,smooth_pixels,where_to_look,Avg_Range,FilterFileName,FilterFileName2,t1,t2)


%% Creating Raw Data and Isolating Pinholes
[RawData]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Final,max_x,max_y,~]=SelectPinhole_Imbedded_v7(RawData,params,col1,row,500,500,smoothing_type,smooth_pixels,where_to_look,1);
[Final2,max_x2,max_y2,~]=SelectPinhole_Imbedded_v7(RawData,params,col2,row,500,500,smoothing_type,smooth_pixels,where_to_look,1);

Range=RealUnits2Pixels(1.35,params);
X=Avg_Range;
Y=Range;
Z=(1.35/Range)*[0:1:Range]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=Final;
a_x=max_x;
a_y=max_y;
thickness=1;
A((a_y-thickness):(a_y+thickness),(a_x-X):(a_x+X))=NaN;
A((a_y-thickness-Y):(a_y+thickness-Y),(a_x-X):(a_x+X))=NaN;

A((a_y-Y):(a_y),(a_x-X-thickness):(a_x-X+thickness))=NaN;
A((a_y-Y):(a_y),(a_x+X-thickness):(a_x+X+thickness))=NaN;


B=Final2;
b_x=max_x2;
b_y=max_y2;
thickness=2;
B((b_y-thickness):(b_y+thickness),(b_x-X):(b_x+X))=NaN;
B((b_y-thickness-Y):(b_y+thickness-Y),(b_x-X):(b_x+X))=NaN;

B((b_y-Y):(b_y),(b_x-X-thickness):(b_x-X+thickness))=NaN;
B((b_y-Y):(b_y),(b_x+X-thickness):(b_x+X+thickness))=NaN;



% 
% Full_x=(params.ccd_xwidth/4200)*[1:4200];
% Full_y=(params.ccd_ywidth/4200)*[1:4200];

% figure()
% mesh(Full_x,Full_y,RawData)
% colorbar
% caxis([0 8000]) %Setting the color bar limits
% view(2)
% xlim([0 36])
% ylim([0 36])
% xlabel('[mm]')
% ylabel('[mm]')
% title('Processed Image')
% set(gca,'FontSize',30)


% PlotPinhole(Final)
% PlotPinhole(Final2)
% PlotArray(RawData)



[Lineout_Y]=AllignPinholes_v2(Final,Final2,Avg_Range,max_x,max_y,max_x2,max_y2);


%% Creating Lineouts

lineout=Lineout_Y(:,1);
lineout2=Lineout_Y(:,2);
[full_lineout,full_lineout2]=GenerateLineouts_v2(lineout,lineout2,RealUnits2Pixels(0.05,params),Range);

lineout_upper=full_lineout(:,1);
lineout2_upper=full_lineout2(:,1);

lineout=full_lineout(:,2);
lineout2=full_lineout2(:,2);

lineout_lower=full_lineout(:,3);
lineout2_lower=full_lineout2(:,3);


%% Grabbing Transmission Coefficients 
%  [~,T_1]=GetFilterTransmission_v2(FilterFileName,FilterFileName2,t2,t2,0.1,one_or_two); %First Pinhole
% [E,T_2]=GetFilterTransmission_v2(FilterFileName,FilterFileName2,t1,t2,0.1,1); %Pinhole to the right of it

% [E,T_Al]=GetFilterTransmission(FilterFileName,t1,0.1);
%[~,T_Be]=GetFilterTransmission(FilterFileName2,t2,0.1);

% T_1(:,1)=T_Al(:,1).*T_Be(:,1);
% T_1(:,2)=T_Al(:,2).*T_Be(:,2);
% T_1(:,3)=T_Al(:,3).*T_Be(:,3);

% T_2=T_Al;

if isequal(FilterFileName2,'Al_10um.txt')==1

[E,T_1]=GetFilterTransmission(FilterFileName,t1,0.1);
[~,T_2]=GetFilterTransmission(FilterFileName2,t2,0.1);

%  T=[upper_T new_trans_coeff lower_T];
T_1_U=T_1(:,1);
T_1_N=T_1(:,2);
T_1_L=T_1(:,3);

T_2_U=T_2(:,1);
T_2_N=T_2(:,2);
T_2_L=T_2(:,3);


else
    
   [E,T_Al]=GetFilterTransmission(FilterFileName,t1,0.1);
   [~,T_Be]=GetFilterTransmission(FilterFileName2,t2,0.1);

   T_1=T_Al;
   T_2=T_Al.*T_Be;
%  T=[upper_T new_trans_coeff lower_T];
    T_1_U=T_1(:,1);
    T_1_N=T_1(:,2);
    T_1_L=T_1(:,3);

    T_2_U=T_2(:,1);
    T_2_N=T_2(:,2);
    T_2_L=T_2(:,3); 
    
end

%% Defining Physical Parameters
T=logspace(2,4,1001); %Defining temperature range


%% Integration

[Integral_1_U]=IntegrateTheStuff(E,T,T_1_U); %Pinhole [row,col]=[2,1]
[Integral_2_U]=IntegrateTheStuff(E,T,T_2_U); %Pinhole [row,col]=[2,2]

[Integral_1_N]=IntegrateTheStuff(E,T,T_1_N); %Pinhole [row,col]=[2,1]
[Integral_2_N]=IntegrateTheStuff(E,T,T_2_N); %Pinhole [row,col]=[2,2]

[Integral_1_L]=IntegrateTheStuff(E,T,T_1_L); %Pinhole [row,col]=[2,1]
[Integral_2_L]=IntegrateTheStuff(E,T,T_2_L); %Pinhole [row,col]=[2,2]


R_1=Integral_2_U./Integral_1_U; %Size of 1x101
R_N=Integral_2_N./Integral_1_N; %Size of 1x101
R_2=Integral_2_L./Integral_1_L; %Size of 1x101

R=[R_1 R_N R_2];

G_1=Integral_2_U./Integral_1_L; %Size of 1x101
G_2=Integral_2_L./Integral_1_U; %Size of 1x101


G=[G_1 G_2];


%% Lineout Comparison
S_1=lineout2_upper./lineout_lower;
S_0=lineout2./lineout;
S_2=lineout2_lower./lineout_upper;


S=[S_1 S_0 S_2];


end