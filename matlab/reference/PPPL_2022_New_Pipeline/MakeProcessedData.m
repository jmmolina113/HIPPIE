function [RawData] = MakeProcessedData(shot_location,cal_location,shot_seq_port)

params=GrabParams_v3(shot_seq_port); %arg(GrabParams)=(ShotDate_ShotSeq_ShotPort)
cal_params=GrabCalParams(params.cal_shot); %arg(GrabParams)=(ShotDate_ShotSeq)
[shot_data,cal_data] = ReadHDF5Data(shot_location,cal_location);


%Defining Rotation matrices any nessecary rotations (were not nessecary in any of the shots I worked this so I never fully developed this. Sorry - Jacob)
ang=(2*pi/360)*(params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix

%Applying any nessecary reflections
shot_data=Mirror(shot_data,params.mirror);




%% Pt.2 - Creating Calibration Image

cal_data=Mirror(cal_data,cal_params.mirror); %Rotating everything so the plasma expands downward by convention

avg=mean(mean(cal_data)); %Defining average by which to flatfield the data
flatfield=cal_data/avg; %Flatfielding the data

%Flooring the flatfield
for i=1:size(flatfield,1)
    for j=1:size(flatfield,2)
    
        if flatfield(i,j)==0
        
          flatfield(i,j)=1;
  
        end
        
    end
end

%% Final Raw Data

RawData=shot_data./flatfield; %Generating the raw data



end

