clear all
close all

shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
shot_seq_port='210317_002_90-124';

% shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
% cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
% shot_seq_port='210317_002_90-78';


RawData=MakeProcessedData(shot_location,cal_location,shot_seq_port);
params=GrabParams_v2(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 
% [Guess,Corrected,Z]=SelectPinhole_Imbedded_v2(RawData,params,col,row,max_col,max_row)
% [Guess,Corrected,Smoothed]=SelectPinhole_Imbedded_v2(RawData,params,3,1,500,500,30);
% [Guess2,Corrected2,Smoothed2]=SelectPinhole_Imbedded_v2(RawData,params,4,1,500,500,30);

[Guess,Corrected,Smoothed]=SelectPinhole_Imbedded_v4(RawData,params,1,3,500,500,25);
[Guess2,Corrected2,Smoothed2]=SelectPinhole_Imbedded_v4(RawData,params,2,3,500,500,25);


%Where do col and row start from??

figure()
mesh(Guess)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with guess box')

figure()
mesh(Corrected)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with adjusted box')

figure()
mesh(Smoothed)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Smoothed')

figure()
mesh(Guess2)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with guess box2')

figure()
mesh(Corrected2)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with adjusted box2')

figure()
mesh(Smoothed2)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Smoothed2')



% [new_max_location_y, new_max_location_x] = find(ismember(Corrected, max(Corrected(:)))); %Finds the coordinates of the max in the region
% 
% new_max_location_x
% new_max_location_y



