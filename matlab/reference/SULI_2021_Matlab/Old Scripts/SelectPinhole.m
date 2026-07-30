function [Guess,Corrected]=SelectPinhole(RawData,params,col,row)

ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;
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


%[fake_y, fake_x] = find(ismember(PinToPlot, max(PinToPlot(:)))); %Finds the coordinates of the max in the region

Z=Guess(300:700,200:800);
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region

old_y=old_y_u+299;

old_x=old_x_u+199;

diff_x=(new_x-old_x);
diff_y=(new_y-old_y);

Corrected_x=x-diff_x;
Corrected_y=y-diff_y;
Guess=RawData(y,x);
Corrected=RawData(Corrected_y,Corrected_x);
[Guess,Corrected];

end


