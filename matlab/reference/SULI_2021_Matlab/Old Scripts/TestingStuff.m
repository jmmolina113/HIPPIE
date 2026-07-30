clear all
close all
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='210317_002_90-124';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% figure()
% plot(X,Y)
% hold on
% plot(Energies,K)
% hold on
% plot(Energies,A)
% set(gca, 'YScale', 'log')
% ylim([0.01 10])
% xlim([0 10000])


% 
% 
% [lineout1_x,lineout1_y]=GenerateLineouts(max_x,max_y,500,500,10,Final);
% [lineout2_x,lineout2_y]=GenerateLineouts(max_x2,max_y,500,500,10,Final2);
% 


% lineout1_x=smoothdata(lineout1_x,'movmean',31);
% lineout1_y=smoothdata(lineout1_y,'movmean',31);
% 
% lineout2_x=smoothdata(lineout2_x,'movmean',31);
% lineout2_y=smoothdata(lineout2_y,'movmean',31);

% g1_x=gradient(lineout1_x);
% g1_y=gradient(lineout1_y);
% g2_x=gradient(lineout2_x);
% g2_y=gradient(lineout2_y);
% 
% [lineout1_x,new1_x]=AlignGradient(lineout1_x,400);
% [lineout2_x,new2_x]=AlignGradient(lineout2_x,400);
% 
% [lineout1_y,new1_y]=AlignGradient(lineout1_y,400);
% [lineout2_y,new2_y]=AlignGradient(lineout2_y,400);






% figure()
% plot((1:size(lineout1_x,1)),g1_x)
% hold on
% plot((1:size(lineout1_x,1)),g2_x)
% hold off
% title('Gradient of Horizontal Lineout')
% legend('[3,3]','[4,3]')
% 
% 
% 
% figure()
% plot((1:size(lineout1_x,1)),g1_y)
% hold on
% plot((1:size(lineout1_x,1)),g2_y)
% hold off
% title('Gradient of Vertical Lineout')
% legend('[3,3]','[4,3]')

% 
% figure()
% plot([1:size(lineout1_y,1)],lineout1_y)
% hold on
% plot([1:size(lineout1_y,1)],lineout2_y)
% hold on
% %plot([1:size(lineout1_y,1)],extra1_y)
% hold on
% %plot([1:size(lineout1_y,1)],extra2_y)
% hold off
% xlim([0 1051])
% 
% title(' Vertical Max Lineout - Unnormalized')
% legend('[3,3]','[4,3]')
% 
% figure()
% plot([1:size(lineout1_x,1)],lineout1_x)
% hold on
% plot([1:size(lineout1_x,1)],lineout2_x)
% hold on
% %plot([1:size(lineout1_x,2)],extra1_x)
% hold on
% %plot([1:size(lineout1_x,2)],extra2_x)
% hold off
% xlim([0 1051])
% 
% 
% title('Horizontal Max Lineout - Unnoramlzied')
% legend('[3,3]','[4,3]')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

close all
[energy,trans_coeff]=GetFilterTransmission('Al_10um.txt',25,0);

figure()
plot(energy,trans_coeff)
hold on
plot(energy2,trans_coeff2)
legend('10 to 5',' original 5')

