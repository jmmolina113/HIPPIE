function [R]=theoreticalAnalysis_2D(row,col1,col2,filterDataLocation,didSwitch,params)

%% Grabbing Transmission Coefficients 
% The following selection statements are in place to switch what the code 
% identifies as pinhole 1 and pinhole 2. The pipeline presupposes pinhole 1
% is the pinhole with the high signal/resolution for alignment purposes, so
% if we do switch the two pinholes prior to processing we need to switch
% what filter information corresponds to a given pinhole as well.


if didSwitch == 0 % extracting filter information if we did not switch the pinholes


    [filterFileName1_pinhole1,filterFileName2_pinhole1]=extractFilterFileName(params,row,col1,filterDataLocation);
    [filterFileName1_pinhole2,filterFileName2_pinhole2]=extractFilterFileName(params,row,col2,filterDataLocation);

    
    [thickness1_pinhole1,thickness2_pinhole1]=extractFilterThicknesses(params,row,col1);
    [thickness1_pinhole2,thickness2_pinhole2]=extractFilterThicknesses(params,row,col2);


elseif didSwitch == 1 % extracting filter information if we did switch the pinholes

    [filterFileName1_pinhole1,filterFileName2_pinhole1]=extractFilterFileName(params,row,col2,filterDataLocation);
    [filterFileName1_pinhole2,filterFileName2_pinhole2]=extractFilterFileName(params,row,col1,filterDataLocation);


    [thickness1_pinhole1,thickness2_pinhole1]=extractFilterThicknesses(params,row,col2);
    [thickness1_pinhole2,thickness2_pinhole2]=extractFilterThicknesses(params,row,col1);

end

% Calculating the transmission curves for both pinhole filters
[energyData,transmissionCurve1_full]=calculateTransmissionCurves(filterFileName1_pinhole1,filterFileName2_pinhole1,thickness1_pinhole1,thickness2_pinhole1);
[~,transmissionCurve2_full]=calculateTransmissionCurves(filterFileName1_pinhole2,filterFileName2_pinhole2,thickness1_pinhole2,thickness2_pinhole2);


%% Defining Physical Parameters
temperatureSpace=logspace(2,4,1001); %Defining temperature range


%% Integration

[Integral1_upperBound]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve1_full(:,1)); %Integrating the upper bound of pinhole 1
[Integral2_upperBound]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve2_full(:,1)); %Integrating the upper bound of pinhole 2

[Integral1]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve1_full(:,2)); %Integrating pinhole 1
[Integral2]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve2_full(:,2)); %Integrating pinhole 2

[Integral1_lowerBound]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve1_full(:,3)); %Integrating the lower bound of pinhole 1
[Integral2_lowerBound]=calculateTheoreticalRatio(energyData,temperatureSpace,transmissionCurve2_full(:,3)); %Integrating the lower bound of pinhole 2


G_1=Integral2_upperBound./Integral1_lowerBound; %Upper limit of the error on the integral analysis
G_2=Integral2_lowerBound./Integral1_upperBound; %Lower limit of the error on the integral analysis
R_N=Integral2./Integral1; %Taking ratio of answer

R=[G_1 R_N G_2]; %Putting it all in an array


%figure
%plot(temperatureSpace,R_N)
%title("Theoreitcal Signal Ratio Calculation")

end