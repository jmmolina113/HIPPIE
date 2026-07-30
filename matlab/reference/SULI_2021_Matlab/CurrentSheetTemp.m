close all
clear all


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
[Te_2ns]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
%%


%%%%% N210317-002: 3 & 4 ns
%%%%%3ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='210317_002_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=3;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.69;
[Te_3ns,Final3_1,Final3_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final3_2)
title('Pinhole 1 - 3ns')
PlotPinhole(Final3_1)
title('Pinhole 2 - 3ns')


row=3;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.82;
[Te_4ns,Final4_1,Final4_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final4_2)
title('Pinhole 1 - 4ns')
PlotPinhole(Final4_1)
title('Pinhole 2 - 4ns')

%%%% N201117-004: 5 & 6 ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='201117_004_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=3;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.69;
[Te_5ns,Final5_1,Final5_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final5_2)
title('Pinhole 1 - 5ns')
PlotPinhole(Final5_1)
title('Pinhole 2 - 5ns')


row=3;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.82;
[Te_6ns,Final6_1,Final6_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final6_1)
title('Pinhole 1 - 6ns')
PlotPinhole(Final6_2)
title('Pinhole 2 - 6ns')


%%%% N210317-001: 7 & 8 ns
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
shot_seq_port='210317_001_90-78';
where_to_look = 0; %-1 -> left, 0 -> center, 1 -> right

row=3;
col1=1;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.69;
[Te_7ns,Final7_1,Final7_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final7_2)
title('Pinhole 1 - 7ns')
PlotPinhole(Final7_1)
title('Pinhole 2 - 7ns')


row=3;
col1=3;
FilterFileName='Al_10um.txt';
FilterFileName2='Al_10um.txt';
t1=3.22;
t2=4.82;
[Te_8ns,Final8_1,Final8_2]=EstimateElectronTemperature(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
PlotPinhole(Final8_2)
title('Pinhole 1 - 8ns')
PlotPinhole(Final8_1)
title('Pinhole 2 - 8ns')
