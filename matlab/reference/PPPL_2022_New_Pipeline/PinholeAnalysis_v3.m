function [S,R]=PinholeAnalysis_v3(shotLocation,calLocation,shot_seq_port,row,col1,col2,smoothingType,smoothPixels,whereToLook,paraRange,perpRange,filterDataLocation)


%% Creating Raw Data and Isolating Pinholes
[RawData]=MakeProcessedData(shotLocation,calLocation,shot_seq_port);
params=GrabParams_v3(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 

PlotArray(RawData)

[pinhole1,~,~]=SelectPinhole_v2(RawData,col1,row,500,500,smoothingType,smoothPixels,whereToLook,1); %Isolating the pinhole of interest
[pinhole2,~,~]=SelectPinhole_v2(RawData,col2,row,500,500,smoothingType,smoothPixels,whereToLook,1); %Isolating the second pinhole of interest

[pinhole1,pinhole2,didSwitch]=switchPinholes(pinhole1,pinhole2);

lineout1=mean(pinhole1(:,(500-perpRange):(500+perpRange)),2,"omitnan");
lineout2=mean(pinhole2(:,(500-perpRange):(500+perpRange)),2,"omitnan");

figure()
plot(normalize(lineout1),'b-','LineWidth',2.5)
hold on
plot(normalize(lineout2),'r-','LineWidth',2.5)
title("Pre-Alignment")
legend("Pinhole 1","Pinhole 2")


[pinhole1_aligned,pinhole2_aligned,netShiftVert,~]=alignPinholes(pinhole1,pinhole2,whereToLook,perpRange); %Aligning both pinholes

lineout1=mean(pinhole1_aligned(:,(500-perpRange):(500+perpRange)),2,"omitnan");
lineout2=mean(pinhole2_aligned(:,(500-perpRange):(500+perpRange)),2,"omitnan");

figure()
plot(normalize(lineout1),'b-','LineWidth',2.5)
hold on
plot(normalize(lineout2),'r-','LineWidth',2.5)
title("Post-Alignment")
legend("Pinhole 1","Pinhole 2")

%% vvvvv Uncomment to plot vvvvv
% PlotPinhole(pinhole1_aligned)
% PlotPinhole(pinhole2_aligned)

X=perpRange;
Y=paraRange;

A=pinhole1_aligned;
a_x=500;
a_y=500;
thickness=3;
A((a_y-thickness):(a_y+thickness),(a_x-X):(a_x+X))=NaN;
A((a_y-thickness-Y):(a_y+thickness-Y),(a_x-X):(a_x+X))=NaN;

A((a_y-Y):(a_y),(a_x-X-thickness):(a_x-X+thickness))=NaN;
A((a_y-Y):(a_y),(a_x+X-thickness):(a_x+X+thickness))=NaN;


B=pinhole2_aligned;
b_x=500;
b_y=500;
thickness=3;
B((b_y-thickness):(b_y+thickness),(b_x-X):(b_x+X))=NaN;
B((b_y-thickness-Y):(b_y+thickness-Y),(b_x-X):(b_x+X))=NaN;

B((b_y-Y):(b_y),(b_x-X-thickness):(b_x-X+thickness))=NaN;
B((b_y-Y):(b_y),(b_x+X-thickness):(b_x+X+thickness))=NaN;

PlotPinhole(A)
PlotPinhole(B)


%% Generating lineouts and isolating the region of interest
[lineout1_final,lineout2_final]=generateLineouts(pinhole1_aligned,pinhole2_aligned,perpRange,paraRange,params,netShiftVert);


lineout1_upperBound=lineout1_final(:,1); %Upper limit of the error in lineout 1
lineout2_upperBound=lineout2_final(:,1); %Upper limit of the error in lineout 2

lineout=lineout1_final(:,2); %Answer 
lineout2=lineout2_final(:,2); %Answer

lineout_lowerBound=lineout1_final(:,3); %Lower limit of the error in lineout 1
lineout2_lowerBound=lineout2_final(:,3); %Lower limit of the error in lineout 2





%% Grabbing Transmission Coefficients 

%This is my current work around to the problem of having to deal with
%pinholes with multiple filters. This is another area of potential
%improvement


if didSwitch==0


    [filterFileName1_pinhole1,filterFileName2_pinhole1]=extractFilterFileName(params,row,col1,filterDataLocation);
    [filterFileName1_pinhole2,filterFileName2_pinhole2]=extractFilterFileName(params,row,col2,filterDataLocation);

    
    [pinhole1_thickness1,pinhole1_thickness2]=extractFilterThicknesses(params,row,col1);
    [pinhole2_thickness1,pinhole2_thickness2]=extractFilterThicknesses(params,row,col2);

    [energyData,transmissionCurve1_full]=GetFilterTransmission_v2(filterFileNames(1,:),thicknesses(1),0.1);
    [~,transmissionCurve2_full]=GetFilterTransmission_v2(filterFileNames(2,:),thicknesses(2),0.1);

    if filterFile
    
    transmissionCurve1_upperBound=transmissionCurve1_full(:,1);
    transmissionCurve1=transmissionCurve1_full(:,2);
    transmissionCurve1_lowerBound=transmissionCurve1_full(:,3);
    
    transmissionCurve2_upperBound=transmissionCurve2_full(:,1);
    transmissionCurve2=transmissionCurve2_full(:,2);
    transmissionCurve2_lowerBound=transmissionCurve2_full(:,3);




elseif didSwitch==1


[pinhole1_thickness1,pinhole1_thickness2]=extractFilterThicknesses(params,row,col2);
[pinhole2_thickness1,pinhole2_thickness2]=extractFilterThicknesses(params,row,col1);


end


% 
% if isequal(filterFileNames(1,:),filterFileNames(2,:))==1
% 
%     [energyData,transmissionCurve1_full]=GetFilterTransmission_v2(filterFileNames(1,:),thicknesses(1),0.1);
%     [~,transmissionCurve2_full]=GetFilterTransmission_v2(filterFileNames(2,:),thicknesses(2),0.1);
%     
%     transmissionCurve1_upperBound=transmissionCurve1_full(:,1);
%     transmissionCurve1=transmissionCurve1_full(:,2);
%     transmissionCurve1_lowerBound=transmissionCurve1_full(:,3);
%     
%     transmissionCurve2_upperBound=transmissionCurve2_full(:,1);
%     transmissionCurve2=transmissionCurve2_full(:,2);
%     transmissionCurve2_lowerBound=transmissionCurve2_full(:,3);
% 
% 
% else
%     
%     [energyData,transmissionCurve1_full]=GetFilterTransmission_v2(filterFileNames(1,:),thicknesses(1),0.1);
%     [~,transmissionCurve2_full]=GetFilterTransmission_v2(filterFileNames(2,:),thicknesses(2),0.1);
% 
%     transmissionCurve1_full=transmissionCurve1_full;
%     transmissionCurve2_full=transmissionCurve1_full.*transmissionCurve2_full;
% 
%     transmissionCurve1_upperBound=transmissionCurve1_full(:,1);
%     transmissionCurve1=transmissionCurve1_full(:,2);
%     transmissionCurve1_lowerBound=transmissionCurve1_full(:,3);
% 
%     transmissionCurve2_upperBound=transmissionCurve2_full(:,1);
%     transmissionCurve2=transmissionCurve2_full(:,2);
%     transmissionCurve2_lowerBound=transmissionCurve2_full(:,3); 
%     
% end

%% Defining Physical Parameters
temperatureSpace=logspace(2,4,1001); %Defining temperature range


%% Integration

[Integral1_upperBound]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve1_upperBound); %Integrating the upper bound of pinhole 1
[Integral2_upperBound]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve2_upperBound); %Integrating the upper bound of pinhole 2

[Integral1]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve1); %Integrating pinhole 1
[Integral2]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve2); %Integrating pinhole 2

[Integral1_lowerBound]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve1_lowerBound); %Integrating the lower bound of pinhole 1
[Integral2_lowerBound]=IntegrateTheStuff(energyData,temperatureSpace,transmissionCurve2_lowerBound); %Integrating the lower bound of pinhole 2


G_1=Integral2_upperBound./Integral1_lowerBound; %Upper limit of the error on the integral analysis
G_2=Integral2_lowerBound./Integral1_upperBound; %Lower limit of the error on the integral analysis
R_N=Integral2./Integral1; %Taking ratio of answer

R=[G_1 R_N G_2]; %Putting it all in an array

%% Lineout Comparison
S_1=lineout2_upperBound./lineout_lowerBound; %Upper Bound on error in signal ratio analysis
S_0=lineout2./lineout; %Signal Ratio of lineouts
S_2=lineout2_lowerBound./lineout1_upperBound; %Lower Bound on error in signal ratio analysis
    
S=[S_1 S_0 S_2]; %Putting it all in an array 


end