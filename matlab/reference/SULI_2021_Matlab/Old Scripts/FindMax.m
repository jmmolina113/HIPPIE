function [min_X, min_Y]=FindMax(RawData,params)

ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;
n=(size(RawData,1)/(params.ncol)); %cutting the image into a grid in the x direction
m=(size(RawData,2)/(params.nrow)); %cutting the image into a grid in the y direction

X_data=zeros(params.nrow,params.ncol);
Y_data=zeros(params.nrow,params.ncol);

for i=1:4   
for j=1:4
       
a=i-1;
b=j-1;
x=[(a*n):1:(i*n)];
y=[(m*b):1:(j*m)];

if min(x)==0
    x=x+1;
end

if min(y)==0
    y=y+1;
end
Guess=RawData(y,x); %This estbalishes the guess region. Suppose we wanted to target the guy that is 3 over and 2 up from my
%Discord image
%[fake_y, fake_x] = find(ismember(PinToPlot, max(PinToPlot(:)))); %Finds the coordinates of the max in the region
Z=Guess(300:700,200:800);
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region

old_y=old_y_u+299;

old_x=old_x_u+199;

X_data(i,j)=old_x;
Y_data(i,j)=old_y;

end
end

min_X=min(X_data(:));
min_Y=min(Y_data(:));


end