function [Final,max_y,max_x]=SelectPinhole_Imbedded_v4(RawData,params,col,row,max_col,max_row,smooth_type,pixels)

%RawData = data to work with

%params = parameters for data to work with

%col = column of pinhole you want to plot (left most column is the 1st column)

%row = row of pinhole you want to plot (bottom most row is the 1st row)

%max_col = the column, within the 1051x1051 pinhole, you want to place the max
%(x-coordinate)

%max_row = the row, within the 1051x1051 pinhole, you want to place the max
%(y-coordinate)

%pixels = number of pixels to smooth over 

A=NaN(6200,6200); %Array of NaN values to imbed the data into
A=cast(A,'single'); %Converting array from type 'double' -> 'single'
Size_x=size(RawData,1);
Size_y=size(RawData,2);
A(1000:(Size_x+999),1000:(Size_y+999))=RawData;
% RawData=smoothdata(RawData,'rlowess',pixels);
% T=transpose(RawData);
% T=smoothdata(T,'rlowess',pixels);
% RawData=transpose(T);

ccdx=params.ccd_xwidth;
ccdy=params.ccd_ywidth;
mag=params.mag;

n=(size(RawData,1)/(4)); %cutting the image into a grid in the x direction
m=(size(RawData,2)/(4)); %cutting the image into a grid in the y direction

a=col-1;
b=row-1;
x=[(a*m):1:(col*m)]; %Defining x-range of 1st guess region
y=[(n*b):1:(row*n)]; %Defining y-range of 1st guess region

if min(x)==0
    x=x+1; %Little nudge to avoid weird errors that occur with the edges
end

if min(y)==0
    y=y+1; %Little nudge to avoid weird errors that occur with the edges
end

Guess=RawData(y,x); %This estbalishes the guess region. Suppose we wanted to target the guy that is 3 over and 2 up from my
%Discord image

Guess=smoothdata(Guess,smooth_type,pixels);
T=transpose(Guess);
T=smoothdata(T,smooth_type,pixels);
Guess=transpose(T);

Z=Guess(100:900,200:800); %Specifying yet another guess region

%(i.e., this is another guess we have to use in order to avoid non-localized maxmia)

new_x=max_col; %Where we want the peak to be in the isolated image (x-coodinate)
new_y=max_row; %Where we want the peak to be in the isolated image (y-coodinate) Make these input parameter

[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
%(i.e., this is another guess we have to use in order to avoid non-localized maxmia)

old_y=old_y_u+99; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
old_x=old_x_u+199; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region

diff_x=(new_x-old_x); %Defining Difference between where the max is and where we want it to be in the x-direction
diff_y=(new_y-old_y); %Defining Difference between where the max is and where we want it to be in the y-direction

Corrected_x=x-diff_x+999; %Transforms and corrects the location of the maxima such that the new range in x- draws a box in the proper area
Corrected_y=y-diff_y+999; %Transforms and corrects the location of the maxima such that the new range in y- draws a box in the proper are
Corrected=A(Corrected_y,Corrected_x);

Final=smoothdata(Corrected,smooth_type,pixels);
T=transpose(Final);
T=smoothdata(T,smooth_type,pixels);
Final=transpose(T);

Z=Final(100:900,200:800); %Specifying yet another guess region

%(i.e., this is another guess we have to use in order to avoid non-localized maxmia)

[old_y_max, old_x_max] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
%(i.e., this is another guess we have to use in order to avoid non-localized maxmia)

max_y=old_y_max+99; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
max_x=old_x_max+199; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region



end

