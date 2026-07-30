close all
clear all

params=GrabParams(shot_seq,port); %arg(GrabParams)=(ShotDate_ShotSeq,port)

ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;
%ang=(2*pi/360)*(180+params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
ang=(2*pi/360)*(params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix

x=ccdx*(1/(mag*4200))*[1:1:4200]; %Defining x coordinates
y=ccdy*(1/(mag*4200))*[1:1:4200]; %Defining y coordinates

%Defining Reflection Matrices

if params.mirror==1

    Ref=[1 0; 0 -1]; %Reflection across of the y-axis
    xy=[x; y];%Applying rotation
    xy=Rot*Ref*xy;%Applying rotation
    x=xy(1,:); 
    y=xy(2,:)+mag*ccdy;%Shifting the data to make the data start at the origin and lie in the first quadrant
    
elseif params.mirror==2
    
    Ref=[1 0; 0 -1]*[-1 0; 0 1]; %Reflection across X-axis then across Y-axis
    xy=[x; y];%Applying rotation
    xy=Rot*Ref*xy;%Applying rotation
    x=xy(1,:)+mag*ccdx; %Shifting the data to make the data start at the origin and lie in the first quadrant
    y=xy(2,:)+mag*ccdy; %Shifting the data to make the data start at the origin and lie in the first quadrant
    
elseif params.mirror==3

    Ref=[1 0; 0 1]; %Reflection acorss the Y-axis
    xy=[x; y];%Applying rotation
    xy=Rot*Ref*xy;%Applying rotation
    x=xy(1,:);
    y=xy(2,:); %Shifting the data to make the data start at the origin and lie in the first quadrant
      
end

%Uncomment to Plot Pt. 1
% z=data;
% mesh(x,y,z); 
% colorbar
% m=max(max(data));
% caxis([0 1500]) %Setting the color bar limits
% view(2)
% xlim([0 mag*ccdx])
% ylim([0 mag*ccdy])
% ylabel('[mm]')
% xlabel('[mm]')
% title('Image w/o flatfield')
% hold off




%%%Different Shots Organized by Date:

%%May 2018
%('C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\May 2018\TD_TC090-315_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N180513-001-999.h5');
%('C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\May 2018\TD_TC090-315_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N180513-002-999.h5');


%%November 2019
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC000-000_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191113-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191113-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2019\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N191114-002-999.h5';

%%November 2020
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\November 2020\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N201117-004-999';

%%March 2021
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999';




%% Pt.2 - Creating Calibration Image

preshot=h5read(cal_location,'/ATTRIBUTES/PRESHOT_IMAGESPRESHOT_IMAGES/0/DATA/DATA/');
shot=h5read(cal_location,'/ATTRIBUTES/SHOT_IMAGE/DATA/DATA/');
cal_data=shot-preshot; %Background subtraction

ccdx=cal_params.ccd_xwidth;
ccdy=cal_params.ccd_ywidth;

cx=ccdx*(1/(4200))*[1:1:4200]; %Defining x coordinates
cy=ccdy*(1/(4200))*[1:1:4200]; %Defining y coordinates


if cal_params.mirror==1

    Ref=[1 0; 0 -1]; %Reflection across of the X-axis
    cxy=[cx; cy];%Applying rotation
    cxy=Ref*cxy;%Applying rotation
    cx=cxy(1,:); 
    cy=cxy(2,:)+ccdy;%Shifting the data to make the data start at the origin and lie in the first quadrant
    
elseif cal_params.mirror==2
    
    Ref=[1 0; 0 -1]*[-1 0; 0 1]; %Reflection across X-axis then across Y-axis
    cxy=[cx; cy];%Applying rotation
    cxy=Ref*cxy;%Applying rotation
    cx=cxy(1,:)+ccdx; %Shifting the data to make the data start at the origin and lie in the first quadrant
    cy=cxy(2,:)+ccdy; %Shifting the data to make the data start at the origin and lie in the first quadrant
    
elseif cal_params.mirror==3

    Ref=[1 0; 0 1]; %Reflection acorss the Y-axis
    cxy=[cx; cy];%Applying rotation
    cxy=Ref*cxy;%Applying rotation
    cx=cxy(1,:);
    cy=cxy(2,:); %Shifting the data to make the data start at the origin and lie in the first quadrant
      
end


cal_data=cast(cal_data,'uint32');
cal_data=cast(cal_data,'single');
avg=mean(mean(cal_data));
flatfield=cal_data/avg;

for i=1:size(flatfield,1)
    for j=1:size(flatfield,2)
    
        if flatfield(i,j)==0
        
          flatfield(i,j)=1;
  
        end
        
    end
end







%Uncomment to Plot Pt. 2
% figure()
% mesh(cx,cy,z)
% colorbar
% caxis([0 2]) %Setting the color bar limits
% view(2)
% xlim([0 ccdx])
% ylim([0 ccdy])
% ylabel('[mm]')
% xlabel('[mm]')
% title('Flatfield')
% hold off


%Calibration Shots

%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC000-000_GXD4F_CALIBRATION_N140515-004-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC000-000_GXD4F_CALIBRATION_N140627-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD3F_CALIBRATION_N130319-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-003-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180916-004-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-001-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-124_GXD3F_CALIBRATION_N191110-002-999.h5';
%'C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-315_GXD3F_CALIBRATION_N180916-003-999.h5';



%% Final Raw Data

data=cast(data,'single');
RawData=data./flatfield;


z=RawData;

% ccdx=params.ccd_xwidth;
% ccdy=params.ccd_ywidth;
% mag=params.mag;
% ang=(2*pi/360)*(180); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
% Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix
% xy=[x; y];%Applying rotation
% xy=Rot*xy;%Applying rotation
% x=xy(1,:)+mag*ccdx; %Shifting the data to make the data start at the origin and lie in the first quadrant
% y=xy(2,:)+mag*ccdy;%Shifting the data to make the data start at the origin and lie in the first quadrant


z=rot90(z,2);




figure()
mesh(x,y,z); %Plotting the shot
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
xlim([0 ccdx/mag])
ylim([0 ccdy/mag])
ylabel('[mm]')
xlabel('[mm]')
title('Image w/ flat-field')
hold off

