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
% PlotPinhole(Final2_1)
% title('Pinhole 1 - 2ns')
% PlotPinhole(Final2_2)
% title('Pinhole 2 - 2ns')

% 
% figure()
% plot(T,R_2(:,2),'k')
% hold on
% xline(Te_2ns(:,2),'--b')
% hold on
% plot(T,mean(S_2(:,2))*((zeros(size(T,2),1))+1),'--b')
% hold on
% 
% 
% 
% ylabel('Ratio')
% xlabel('T')
% xlim([100 1000])
% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% ylim([0.005 1])
% eval(['legend("","","","Upper Bound T_{e} ~ ' num2str(round(Te_2ns(1))) 'K","T_{e} ~' num2str(round(Te_2ns(2))) 'K","Lower Bound T_{e} ~ ' num2str(round(Te_2ns(3))) 'K")'])

%%


%%%%% N210317-002: 3 & 4 ns
%%%%%3ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='210317_002_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=2;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Be_10um.txt';
t1=3.22;
t2=12.55;
[Te_3ns,Final3_1,Final3_2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final3_2)
% title('Pinhole 1 - 3ns')
% PlotPinhole(Final3_1)
% title('Pinhole 2 - 3ns')

row=2;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Be_10um.txt';
t1=3.22;
t2=12.55;
[Te_4ns,Final4_1,Final4_2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final4_2)
% title('Pinhole 1 - 4ns')
% PlotPinhole(Final4_1)
% title('Pinhole 2 - 4ns')

%%%% N201117-004: 5 & 6 ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='201117_004_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=2;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Be_10um.txt';
t1=3.22;
t2=12.55;
[Te_5ns,Final5_1,Final5_2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final5_2)
% title('Pinhole 1 - 5ns')
% PlotPinhole(Final5_1)
% title('Pinhole 2 - 5ns')
% 

row=3;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.82;
[Te_6ns,Final6_1,Final6_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final6_1)
% title('Pinhole 1 - 6ns')
% PlotPinhole(Final6_2)
% title('Pinhole 2 - 6ns')


%%%% N210317-001: 7 & 8 ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='210317_001_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=2;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Be_10um.txt';
t1=3.22;
t2=12.55;
[Te_7ns,Final7_1,Final7_2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final7_2)
% title('Pinhole 1 - 7ns')
% PlotPinhole(Final7_1)
% title('Pinhole 2 - 7ns')


row=2;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Be_10um.txt';
t1=3.22;
t2=12.55;
[Te_8ns,Final8_1,Final8_2]=EstimateElectronTemperature_Reverse(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
% PlotPinhole(Final8_2)
% title('Pinhole 1 - 8ns')
% PlotPinhole(Final8_1)
% title('Pinhole 2 - 8ns')

times=[0:8];
Actual2ns=[0 0 0];
T=[Actual2ns; Actual2ns; Actual2ns; Te_3ns; Te_4ns; Te_5ns; Te_6ns; Te_7ns; Te_8ns];
figure()
plot(times,T,'LineWidth',1.25)
legend('Upper Bound','Answer','Lower Bound')
xlabel('Time (ns)')
ylabel('T_{e} (eV)')

Answer=[times' T];

figure()
T_A=T(:,2);
E_L=T(:,2)-T(:,3);
E_H=T(:,1)-T(:,2);
figure()
errorbar(times,T(:,2),E_L,E_H,'--s','MarkerSize',7,'MarkerEdgeColor','blue','MarkerFaceColor','blue','Color','b','LineWidth',2)
xlabel('Time (ns)')
ylabel('T_{e} (eV)')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
xlim([0 8.5])
