clear all
close all

shot_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\X-ray Data\NIF\March 2021\TD_TC090-124_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-002-999.h5';
cal_location='C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Calibrations\TD_TC090-078_GXD4F_CALIBRATION_N180917-002-999.h5';
shot_seq='210317_002';
port='90-78';
col=1;
row=1;
RawData=MakeProcessedData(shot_location,cal_location,shot_seq,port);
params=GrabParams('210317_002',port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 
ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;


figure()
mesh(RawData)
view(2)
caxis([0 1500])
title('Full picture for reference')
hold off


size_x=ccdx/mag;
size_y=ccdy/mag;

n=(size(RawData,1)/params.ncol); %cutting the image into a grid in the x direction
m=(size(RawData,2)/params.nrow); %cutting the image into a grid in the y direction
a=col-1;
b=row-1;
x=[(a*n):1:(col*n)];
y=[(m*b):1:(row*m)];

if min(x)==0
    x=x+1;
end

if min(y)==0
    y=y+1;
end
Guess=RawData(y,x); %This estbalishes the guess region. Suppose we wanted to target the guy that is 3 over and 2 up from my
%Discord image

new_x=497; %Where we want the peak to be in the isolated image (x-coodinate)
new_y=576; %Where we want the peak to be in the isolated image (y-coodinate)

figure()
mesh(Guess)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with guess box')



%[fake_y, fake_x] = find(ismember(PinToPlot, max(PinToPlot(:)))); %Finds the coordinates of the max in the region

Z=Guess(300:700,200:800);
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region

old_y=old_y_u+299;
old_x=old_x_u+199;
% X = old_x+1*n; %x-coordinate of the max relative to the entire image
% Y = old_y+1*m; %y-coordinate of the max relative to the entire image


diff_x=(new_x-old_x);
diff_y=(new_y-old_y);

L=x-diff_x;
W=y-diff_y;

Final=RawData(W,L);

figure()
mesh(Final)
colorbar
caxis([0 1500]) %Setting the color bar limits
view(2)
title('Pinhole plotted with adjusted box')


[new_max_location_y, new_max_location_x] = find(ismember(Final, max(Final(:)))); %Finds the coordinates of the max in the region

new_max_location_x
new_max_location_y





