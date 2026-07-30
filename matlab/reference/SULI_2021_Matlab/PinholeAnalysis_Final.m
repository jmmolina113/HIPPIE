function [S,R]=PinholeAnalysis_Final(shot_location,cal_location,shot_seq_port,row,col1,col2,smoothing_type,smooth_pixels,where_to_look,Para_Range,Perp_Range,FilterFileName,FilterFileName2,t1,t2)


%% Creating Raw Data and Isolating Pinholes
[RawData]=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

[Final,max_x,max_y]=SelectPinhole_Final(RawData,col1,row,500,500,smoothing_type,smooth_pixels,where_to_look,1); %Isolating the pinhole of interest
[Final2,max_x2,max_y2]=SelectPinhole_Final(RawData,col2,row,500,500,smoothing_type,smooth_pixels,where_to_look,1); %Isolating the second pinhole of interest


%% The following lines will generate the data for a pinhole image with a box drawn around the region of interest
% X=Avg_Range;
% Y=Range;
% 
% A=Final;
% a_x=max_x;
% a_y=max_y;
% thickness=1;
% A((a_y-thickness):(a_y+thickness),(a_x-X):(a_x+X))=NaN;
% A((a_y-thickness-Y):(a_y+thickness-Y),(a_x-X):(a_x+X))=NaN;
% 
% A((a_y-Y):(a_y),(a_x-X-thickness):(a_x-X+thickness))=NaN;
% A((a_y-Y):(a_y),(a_x+X-thickness):(a_x+X+thickness))=NaN;
% 
% 
% B=Final2;
% b_x=max_x2;
% b_y=max_y2;
% thickness=2;
% B((b_y-thickness):(b_y+thickness),(b_x-X):(b_x+X))=NaN;
% B((b_y-thickness-Y):(b_y+thickness-Y),(b_x-X):(b_x+X))=NaN;
% 
% B((b_y-Y):(b_y),(b_x-X-thickness):(b_x-X+thickness))=NaN;
% B((b_y-Y):(b_y),(b_x+X-thickness):(b_x+X+thickness))=NaN;


%% Generating full lineout profiles and aligning them
[Lineout_Y]=Generate_and_Align_Lineouts(Final,Final2,Perp_Range,max_x,max_y,max_x2,max_y2);


%% Creating lineouts in the region of interest

lineout=Lineout_Y(:,1);
lineout2=Lineout_Y(:,2);

%This conditional statement is just to flop the signals if the left-most
%pinhole happens to not be the high-signal pinhole

if max(lineout2) > max(lineout)
    
    
    A=lineout;
    B=lineout2;
    lineout=B;
    lineout2=A;
    
    
end



[full_lineout,full_lineout2]=Isolating_Region_of_Interest(lineout,lineout2,RealUnits2Pixels(0.05,params),Para_Range);

lineout_upper=full_lineout(:,1); %Upper limit of the error in lineout 1
lineout2_upper=full_lineout2(:,1); %Upper limit of the error in lineout 2

lineout=full_lineout(:,2); %Answer 
lineout2=full_lineout2(:,2); %Answer

lineout_lower=full_lineout(:,3); %Lower limit of the error in lineout 1
lineout2_lower=full_lineout2(:,3); %Lower limit of the error in lineout 2


%% Grabbing Transmission Coefficients 

%This is my current work around to the problem of having to deal with
%pinholes with multiple pinholes. This is another area of potential
%improvement

if isequal(FilterFileName2,'Al_10um.txt')==1

[E,T_1]=GetFilterTransmission(FilterFileName,t1,0.1);
[~,T_2]=GetFilterTransmission(FilterFileName2,t2,0.1);

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

[Integral_1_U]=IntegrateTheStuff(E,T,T_1_U); %Integrating the upper bound of pinhole 1
[Integral_2_U]=IntegrateTheStuff(E,T,T_2_U); %Integrating the upper bound of pinhole 2

[Integral_1_N]=IntegrateTheStuff(E,T,T_1_N); %Integrating pinhole 1
[Integral_2_N]=IntegrateTheStuff(E,T,T_2_N); %Integrating pinhole 2

[Integral_1_L]=IntegrateTheStuff(E,T,T_1_L); %Integrating the lower bound of pinhole 1
[Integral_2_L]=IntegrateTheStuff(E,T,T_2_L); %Integrating the lower bound of pinhole 2


G_1=Integral_2_U./Integral_1_L; %Upper limit of the error on the integral analysis
G_2=Integral_2_L./Integral_1_U; %Lower limit of the error on the integral analysis
R_N=Integral_2_N./Integral_1_N; %Taking ratio of answer

R=[G_1 R_N G_2]; %Putting it all in an array

%% Lineout Comparison
S_1=lineout2_upper./lineout_lower; %Upper Bound on error in signal ratio analysis
S_0=lineout2./lineout; %Signal Ratio of lineouts
S_2=lineout2_lower./lineout_upper; %Lower Bound on error in signal ratio analysis
    
S=[S_1 S_0 S_2]; %Putting it all in an array 


end