close all
clear all


%Select Shot
shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';

%Select appropriate calibration data to work with
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
shot_seq='210317_002';
port='90-78';
params=GrabParams(shot_seq,port); %arg(GrabParams)=(ShotDate_ShotSeq,port)
cal_params=GrabCalParams(params.cal_shot); %arg(GrabParams)=(ShotDate_ShotSeq)
[shot_data,cal_data] = ReadHDF5Data(shot_location,cal_location);

ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;

x=ccdx*(1/(mag*4200))*[1:1:4200]; %Defining x coordinates
y=ccdy*(1/(mag*4200))*[1:1:4200]; %Defining y coordinates


%APplying any nessecary rotations
ang=(2*pi/360)*(params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix
xy=[x; y];%Applying rotation
xy=Rot*xy;%Applying rotation
x=xy(1,:); %Shifting the data to make the data start at the origin and lie in the first quadrant
y=xy(2,:);%Shifting the data to make the data start at the origin and lie in the first quadrant



%Applying any nessecary reflections
shot_data=Mirror(shot_data,params.mirror);




%% Pt.2 - Creating Calibration Image

ccdx=cal_params.ccd_xwidth;
ccdy=cal_params.ccd_ywidth;


cal_data=Mirror(cal_data,cal_params.mirror);

avg=mean(mean(cal_data));
flatfield=cal_data/avg;

for i=1:size(flatfield,1)
    for j=1:size(flatfield,2)
    
        if flatfield(i,j)==0
        
          flatfield(i,j)=1;
  
        end
        
    end
end

%% Final Raw Data

RawData=shot_data./flatfield;
%RawData=rot90(RawData,2);



%Uncomment to Plot Final Image
% figure()
% mesh(x,y,RawData); %Plotting the shot
% colorbar
% caxis([0 1500]) %Setting the color bar limits
% view(2)
% xlim([0 ccdx/mag])
% ylim([0 ccdy/mag])
% ylabel('[mm]')
% xlabel('[mm]')
% title('Image w/ flat-field')
% hold off

