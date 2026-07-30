%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Different Shots Organized by Date:

%%May 2018
%('C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\May 2018\TD_TC090-315_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N180513-001-999.h5');
%('C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\May 2018\TD_TC090-315_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N180513-002-999.h5');


%%November 2019
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC000-000_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191113-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191113-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';

%%November 2020
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999.h5';

%%March 2021
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Calibration Shots

%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC000-000_GXD4F_CALIBRATION_N140515-004-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC000-000_GXD4F_CALIBRATION_N140627-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD3F_CALIBRATION_N130319-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-004-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-315_GXD3F_CALIBRATION_N180916-003-999.h5';



function [shot_data,cal_data] = ReadHDF5Data(shot_location,cal_location)

preshot=h5read(shot_location,'/ATTRIBUTES/PRESHOT_IMAGESPRESHOT_IMAGES/0/DATA/DATA/'); %Read in the pre-shot data
shot=h5read(shot_location,'/ATTRIBUTES/SHOT_IMAGE/DATA/DATA/'); %Read in the shot data

shot=cast(shot,'int32'); 
preshot=cast(preshot,'int32'); 
shot_data=shot-preshot; %Background subtraction

for i=1:size(shot_data,1)
    for j=1:size(shot_data,2)
        if shot_data(i,j)<0
            
            shot_data(i,j)=0;
            
        end
    end
end

%Now for the calibration

cal_preshot=h5read(cal_location,'/ATTRIBUTES/PRESHOT_IMAGESPRESHOT_IMAGES/0/DATA/DATA/'); %Read in calibration preshot
cal_shot=h5read(cal_location,'/ATTRIBUTES/SHOT_IMAGE/DATA/DATA/'); %Read in calibration shot

cal_shot=cast(cal_shot,'int32'); 
cal_preshot=cast(cal_preshot,'int32'); 
cal_data=cal_shot-cal_preshot; %Background subtraction

for i=1:size(cal_data,1)
    for j=1:size(cal_data,2)
        if cal_data(i,j)<0
            
            cal_data(i,j)=0;
            
        end
    end
end

shot_data=cast(shot_data,'single');
cal_data=cast(cal_data,'single');

[shot_data,cal_data];


end

