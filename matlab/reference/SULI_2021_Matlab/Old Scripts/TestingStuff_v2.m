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
[Te_2ns]=EstimateElectronTemperature_Final(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);


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
[Te_3ns]=EstimateElectronTemperature_Final(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);
