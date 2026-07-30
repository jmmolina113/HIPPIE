function [Te]=EstimateElectronTemperature_v2(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,filterDataLocation,Para_Range,smooth_pixels)

smoothing_type='movmean'; %Defining the method we want to use when we smooth over our pinhole

%smooth_pixels=11;
%smooth_pixels=31;


params=GrabParams_v3(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port)

%Para_Range=RealUnits2Pixels(1.5,params); %How far down the maxima we take our lineout in units of pixels

Perp_Range=RealUnits2Pixels((0.3)/2,params); %How far out in the direction perpendicular to the lineout we want to avergesmooth_pixels=11; %Defining the number of pixels we smooth over when finding our peaks and generating the pinhole to work with

col2=col1+1; %Identifying the pinhole to the right of the column you gave it

[S,R]=PinholeAnalysis_v4(shot_location,cal_location,shot_seq_port,row,col1,col2,smoothing_type,smooth_pixels,where_to_look,Para_Range,Perp_Range,filterDataLocation);

final_lineout_error=lineout_error(S); %Calculating the error in the lineouts

T=logspace(2,4,1001); %Defining temperature range

[Te1]=FindTemp(R(:,1),(mean(S(:,2)))+(final_lineout_error),T); %Finding the upper error bound electron temperature
[TeN]=FindTemp((R(:,2)),(mean(S(:,2))),T); %Finding the electron temperature
[Te2]=FindTemp(R(:,3),(mean(S(:,2)))-(final_lineout_error),T); %Finding the lower error bound electron temperature

Te=[Te1 TeN Te2];

figure()
plot(T,R(:,2),'r-','LineWidth',2.5)
hold on
plot(T,mean(S(:,2))*(zeros(1,length(T))+1),'b--','LineWidth',2.5);
hold on
xline(TeN,'k--','LineWidth',2.5)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
title("R(T_{e}) vs S")
legend('R(T_{e})','mean(S)','Te [eV]')
xlabel("T_{e} [eV]")
ylabel("Ratio of X-Ray Photons")


end


