function [Final,max_x,max_y]=SelectPinhole_Final(RawData,col,row,max_col,max_row,smooth_type,smooth_pixels,location,smoothing_on_off)
%This version outputs the raw data with no smoothing
%RawData = data to work with

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
A(1000:(Size_x+999),1000:(Size_y+999))=RawData; %Imbedding the raw data in this array

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

%%
%This section may need some explaining. Before, I was just looking at a
%1050x1050 image, smoothing, ID'ing the max, shifting the array
%boundaries so as to pu the max where we want it, and then resmoothing.
%What was happening though was that the max would be slightly off after resmoothing
%because of all the new values that were introduced after we shifted things
%around. I now smooth a large patch around the pinhole as well and just
%work within this patch to avoid this issue of having to resmooth.

maxx=max(x)+300; 
may=max(y)+300;

mix=min(x)-300;
miy=min(y)-300;

X=[mix:1:maxx]; %Generating a range of data values
Y=[miy:1:may];

J=A(Y+999,X+999);
M=smoothdata(J,smooth_type,smooth_pixels);
T=transpose(M);
T=smoothdata(T,smooth_type,smooth_pixels);
M=transpose(T);
%%
B=A; %Unsmoothed Data
A(Y+999,X+999)=M; %Smoothed Data

Guess=A(y+999,x+999); %This estbalishes the guess region

new_x=max_col; %Where we want the peak to be in the isolated image (x-coodinate)
new_y=max_row; %Where we want the peak to be in the isolated image (y-coodinate) Make these input parameter

%These conditional statements establish where we are intrested in looking.
% -1 -> left-most plasma bubble
% 0 -> center of the shot where the reconnection region is
% 1 -> right-most plasma bubble

if location==-1
    
Z=Guess(250:800,125:400); %Specifying yet another guess region
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
old_y=old_y_u+249; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
old_x=old_x_u+124; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
    
elseif location==0
    
 Z=Guess(50:600,400:600); %Specifying yet another guess region
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region
old_y=old_y_u+49; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
old_x=old_x_u+399; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region

elseif location==1
    
Z=Guess(250:800,500:900); %Specifying yet another guess region
[old_y_u, old_x_u] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
old_y=old_y_u+249; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
old_x=old_x_u+499; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region

end

diff_x=(new_x-old_x); %Defining Difference between where the max is and where we want it to be in the x-direction
diff_y=(new_y-old_y); %Defining Difference between where the max is and where we want it to be in the y-direction

Corrected_x=x-diff_x+999; %Transforms and corrects the location of the maxima such that the new range in x- draws a box in the proper area
Corrected_y=y-diff_y+999; %Transforms and corrects the location of the maxima such that the new range in y- draws a box in the proper are

if smoothing_on_off == 1
    
Final=A(Corrected_y,Corrected_x);

elseif smoothing_on_off == 0
    
Final=B(Corrected_y,Corrected_x);

end

Z=Final(475:525,475:525); %Specifying a region where the max should be for output purposes
[old_y_max, old_x_max] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
max_y=old_y_max+474; %Transforming back into units of the pinhole
max_x=old_x_max+474; %Transforming back into units of the pinhole


end

