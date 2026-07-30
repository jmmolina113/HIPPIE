close all
clear all


T=logspace(2,4,1001); %Defining temperature range


%%%%% N191114-001: 2 ns

shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='191114_001_90-78';
where_to_look = 1; %-1 -> left, 0 -> center, 1 -> right
row=2;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3;
t2=6.5;
[Te_2ns,Final2_1,Final2_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final2_1)
title('Low Filter Pinhole')
PlotPinhole(Final2_2)
title('High Filter Pinhole')





[E,T_1]=GetFilterTransmission(FilterFileName,t1,0.1);
[~,T_2]=GetFilterTransmission(FilterFileName2,t2,0.1);
K=DetectorResponse(E); %Detector Response


figure()
plot(E,T_1(:,2),'b','LineWidth',2)
hold on
plot(E,T_2(:,2),'r','LineWidth',2)
xlabel('Energy (eV)')
ylabel('Transmission Coefficient (Unitless)')
legend('Al: d = 3 {\mu}m','Al: d = 6.5 {\mu}m')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
title('W(\nu,d)')
ylim([0 1.2])




n=1e-4; %m^-3
Temps=logspace(2,4,1001); %Defining temperature range
j=zeros((size(E,1)),(size(Temps,2)));

for i=1:size(Temps,2)
    
j(:,i)=(n^2/(Temps(i)))*exp(-E/(2*Temps(i))); %Exponential Factor

end

ToPlot=trapz(E,j);
N=ToPlot/(max(ToPlot));
figure()
plot(Temps,N,'b','LineWidth',2)
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
title('Normalized Frequency-Integrated j(\nu,T_{e})')
xlabel('T (eV)')
ylabel('Normalized \int j(\nu,T_{e}) d\nu')
set(gca, 'XScale', 'log')

ylim([0 1.1])



figure()
plot(E,K,'b','LineWidth',2)
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
title('K(\nu)')
ylabel('Detector Response')
xlabel('Energy (eV)')
















% 
% 
% %%%%% Side-On
% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
% shot_seq_port='191114_002_90-124';
% where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right
% % 
% % % 
% %%%%% Face-On
% % shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-001-999.h5';
% % cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
% % shot_seq_port='191114_001_90-78';
% % where_to_look = 1; %-1 -> left, 0 -> center, 1 -> right
% row=2;
% col1=1;
% 
% [Te]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1);
% 

% 
% figure()
% plot(T,G_2(:,1),'r')
% hold on
% plot(T,R_2(:,2),'g')
% hold on
% plot(T,G_2(:,2),'b')
% hold on
% xline(Te_2ns(:,1),'--r')
% hold on
% xline(Te_2ns(:,2),'--g')
% hold on
% xline(Te_2ns(:,3),'--b')
% hold on
% plot(T,mean(S_2(:,1))*((zeros(size(T,2),1))+1),'--r')
% hold on
% plot(T,mean(S_2(:,2))*((zeros(size(T,2),1))+1),'--g')
% hold on
% plot(T,mean(S_2(:,3))*((zeros(size(T,2),1))+1),'--b')
% 
% 
% ylabel('Ratio')
% xlabel('T')
% xlim([100 1000])
% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% ylim([0.005 1])
% eval(['legend("","","","Upper Bound T_{e} ~ ' num2str(round(Te_2ns(1))) 'K","T_{e} ~' num2str(round(Te_2ns(2))) 'K","Lower Bound T_{e} ~ ' num2str(round(Te_2ns(3))) 'K")'])
% 
% 

