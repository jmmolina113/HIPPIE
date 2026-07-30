Example of how to use EstimateElectronTemperature_Final.m:

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
[Te]=EstimateElectronTemperature_Final(shot_location,cal_location,shot_seq_port,where_to_look,row,col1,FilterFileName,FilterFileName2,t1,t2);


\\ shot_ and cal_location specify the the location of the shot and 
calibration shot data

\\ short_seq_port refers to the data identifier (row 1) in
xray_params.xlxs

\\ where_to_look specifies the region of interest that is under
investigation (e.g., -1 focuses on the left side of the image, 0 on the center of the image, and 1 the right side of the image for analysis)
\\ row = row of the shots that are being analyzed. In my convention, 
the first row and column corresponds to the pinhole in the very
bottom left corner of the pinehole array after rotation, calibration, etc.

\\ FilterFileName is the name of the file that contains the
transmission filter information, calculated for standrard
filter thickness, for the left-most pinhole in the pair being analyzed.

\\ FilterFileName2 is the name of the file that contains the
transmission filter information, calculated for standrard
filter thickness, for the right-most pinhole in the pair being analyzed.

\\ t1 corresponds to the filter thickness for the filtering
filtering the left-most pinhole in the pair being analyzed
[units of microns]


\\ t2 corresponds to the filter thickness for the filtering
filtering the left-most pinhole in the pair being analyzed
[units of microns]