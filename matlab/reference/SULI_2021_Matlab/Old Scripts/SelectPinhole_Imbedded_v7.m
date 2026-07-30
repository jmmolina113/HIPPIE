function [Final,max_x,max_y,diff_y]=SelectPinhole_Imbedded_v7(RawData,params,col,row,max_col,max_row,smooth_type,smooth_pixels,location,smoothing_on_off)
%This version outputs the raw data with no smoothing
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
%A=filloutliers(A,'spline','movmean',200,);




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

maxx=max(x)+300;
may=max(y)+300;

mix=min(x)-300;
miy=min(y)-300;

X=[mix:1:maxx];
Y=[miy:1:may];

J=A(Y+999,X+999);
M=smoothdata(J,smooth_type,smooth_pixels);
T=transpose(M);
T=smoothdata(T,smooth_type,smooth_pixels);
M=transpose(T);

B=A;
A(Y+999,X+999)=M;

%A=filloutliers(A,'linear','mean',11);


Guess=A(y+999,x+999); %This estbalishes the guess region. Suppose we wanted to target the guy that is 3 over and 2 up from my
%Discord image

% Guess=smoothdata(Guess,smooth_type,pixels);
% T=transpose(Guess);
% T=smoothdata(T,smooth_type,pixels);
% Guess=transpose(T);

 
new_x=max_col; %Where we want the peak to be in the isolated image (x-coodinate)
new_y=max_row; %Where we want the peak to be in the isolated image (y-coodinate) Make these input parameter

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
Corrected=A(Corrected_y,Corrected_x);
%%%%%%%%%
% Final=smoothdata(Corrected,smooth_type,pixels);
% T=transpose(Final);
% T=smoothdata(T,smooth_type,pixels);
% Final=transpose(T);
%%%%%%%%

if smoothing_on_off == 1
    
Final=A(Corrected_y,Corrected_x);

elseif smoothing_on_off == 0
    
Final=B(Corrected_y,Corrected_x);

end

%Final=filloutliers(Final,'linear','mean',200);

% if location==-1
%     
% Z=Final(250:800,125:600); %Specifying yet another guess region
% [old_y_max, old_x_max] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
% max_y=old_y_max+249; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
% max_x=old_x_max+124; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
%     
% elseif location==0
    
Z=Final(475:525,475:525); %Specifying yet another guess region
[old_y_max, old_x_max] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
max_y=old_y_max+474; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
max_x=old_x_max+474; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
    
% elseif location==1
%     
% Z=Final(250:800,450:550); %Specifying yet another guess region
% [old_y_max, old_x_max] = find(ismember(Z, max(Z(:)))); %Finds the coordinates of the max in the region 
% max_y=old_y_max+249; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
% max_x=old_x_max+449; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
% 
% end

% bckgrnd=mean(Final(:,(490:510)),2);
% %Final=Final-mean(bckgrnd(267:301)); %Avg of 1.5mm - 2mm from Maxima
% %Final=Final-bckgrnd(267); %2mm from Maxima
% %Final=Final-bckgrnd(301); %1.5mm from Maxima
% %Final=Final-bckgrnd(296); %1.75mm from Maxima
% Final_b=Final-mean(bckgrnd(900:925)); %Value out at the 900 pixel mark
% 
% for i=1:size(Final,1)
%     for j=1:size(Final,2)
%         
%         if Final(i,j) < 1
%             
%             Final(i,j)=1;
%             
%         end
%         
%     end
% end




end

