clear all
close all

RawData=readtable('RawData.csv');
port='90-78'; 
params=GrabParams('210317_002',port); %arg(GrabParams)=(ShotDate_ShotSeq,port) 
cal_params=GrabCalParams(params.cal_shot);


ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;
%ang=(2*pi/360)*(180+params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
ang=(2*pi/360)*(params.ang); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix

x=ccdx*(1/(mag*4200))*[1:1:4200]; %Defining x coordinates
y=ccdy*(1/(mag*4200))*[1:1:4200]; %Defining y coordinates

RawData=table2array(RawData);
port='90-78'; 
params=GrabParams('210317_002',port); %arg(GrabParams)=(ShotDate_ShotSeq,port)
N=params.npinholes;
ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;

size_x=ccdx*mag;
size_y=ccdy*mag;

a=(4200/4);
%Suppose we wanted to target the guy that is 3 over and 2 up from my
%Discord image

PinToPlot=RawData(2*a:3*a,1*a:2*a); %This estbalishes the guess region
[X, Y] = find(ismember(PinToPlot, max(PinToPlot(:))));


% 
% mesh(PinToPlot)
% colorbar
% caxis([0 1500]) %Setting the color bar limits
% view(2)






