function [Final,new_x_max_location,new_y_max_location]=SelectPinhole_v2(RawData,col,row,max_col,max_row,smooth_type,smooth_pixels,location,smoothing_on_off)
%This version outputs the raw data with no smoothing
%RawData = data to work with

%col = column of pinhole you want to plot (left most column is the 1st column)

%row = row of pinhole you want to plot (bottom most row is the 1st row)

%max_col = the column, within the 1051x1051 pinhole, you want to place the max
% (x-coordinate) at

%max_row = the row, within the 1051x1051 pinhole, you want to place the max
% (y-coordinate)at

%pixels = number of pixels to smooth over 


Master_array=NaN(6200,6200); %Array of NaN values to imbed the data into
Master_array=cast(Master_array,'single'); %Converting array from type 'double' -> 'single'
Size_x=size(RawData,1); %Finding size in horizontal direction
Size_y=size(RawData,2); %Finding size in vertical direction
Master_array(1000:(Size_x+999),1000:(Size_y+999))=RawData; %Imbedding the raw data in this array

n=(size(RawData,1)/(4)); %cutting the image into a grid in the x direction
m=(size(RawData,2)/(4)); %cutting the image into a grid in the y direction

a=col-1;
b=row-1;
x=[((col-1)*m):1:(col*m)]; %Defining x-range of 1st guess region
y=[((row-1)*n):1:(row*n)]; %Defining y-range of 1st guess region

    if min(x)==0
        x=x+1; %Little nudge to avoid weird errors that occur with the edges
    end
    
    if min(y)==0
        y=y+1; %Little nudge to avoid weird errors that occur with the edges
    end

%%
%This section may need some explaining. Before, I was just looking at a
%1050x1050 image, smoothing, ID'ing the max, shifting the array
%boundaries so as to put the max where we want it, and then resmoothing.
%What was happening though was that the max would be slightly off after resmoothing
%because of all the new values that were introduced after we shifted things
%around. I now smooth a large patch around the pinhole as well and just
%work within this patch to avoid this issue of having to resmooth.

max_x_to_smooth=max(x)+300; 
max_y_to_smooth=max(y)+300;

min_x_to_smooth=min(x)-300;
min_y_to_smooth=min(y)-300;

x_smoothing_range=[min_x_to_smooth:1:max_x_to_smooth]; %Generating a range of data values
y_smoothing_range=[min_y_to_smooth:1:max_y_to_smooth];

Array_to_smooth=Master_array(y_smoothing_range+999,x_smoothing_range+999);
first_smooth=smoothdata(Array_to_smooth,smooth_type,smooth_pixels);
T=transpose(first_smooth);
second_smooth=smoothdata(T,smooth_type,smooth_pixels);
Smoothed_array=transpose(second_smooth);
%%
Unsmoothed_data=Master_array; %Unsmoothed Data
Master_array(y_smoothing_range+999,x_smoothing_range+999)=Smoothed_array; %Smoothed Data

Smoothed_master_array=Master_array;

Guess_region_1=Smoothed_master_array(y+999,x+999); %This estbalishes the guess region

desired_x=max_col; %Where we want the peak to be in the isolated image (x-coodinate)
desired_y=max_row; %Where we want the peak to be in the isolated image (y-coodinate) Make these input parameter

%These conditional statements establish where we are intrested in looking.
% -1 -> left-most plasma bubble
% 0 -> center of the shot where the reconnection region is
% 1 -> right-most plasma bubble

    if location==-1
        
        guess_lower_bound_in_y=250;
        guess_lower_bound_in_x=125;
    
        Guess_region_2=Guess_region_1(guess_lower_bound_in_y:800,guess_lower_bound_in_x:400); %Specifying yet another guess region
        [old_y_max_location_in_guess_2, old_x_max_location_in_guess_2] = find(ismember(Guess_region_2, max(Guess_region_2(:)))); %Finds the coordinates of the max in the region 
        old_y_max_location=old_y_max_location_in_guess_2+guess_lower_bound_in_y-1; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
        old_x_max_location=old_x_max_location_in_guess_2+guess_lower_bound_in_x-1; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
            
    elseif location==0
    
        guess_lower_bound_in_x=400;
        guess_lower_bound_in_y=50;
        
        Guess_region_2=Guess_region_1(guess_lower_bound_in_y:600,guess_lower_bound_in_x:600); %Specifying yet another guess region
        [old_y_max_location_in_guess_2, old_x_max_location_in_guess_2] = find(ismember(Guess_region_2, max(Guess_region_2(:)))); %Finds the coordinates of the max in the region
        old_y_max_location=old_y_max_location_in_guess_2+guess_lower_bound_in_y-1; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
        old_x_max_location=old_x_max_location_in_guess_2+guess_lower_bound_in_x-1; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
    
    elseif location==1
    
        guess_lower_bound_in_x=500;
        guess_lower_bound_in_y=250;
        
        Guess_region_2=Guess_region_1(guess_lower_bound_in_y:800,guess_lower_bound_in_x:900); %Specifying yet another guess region
        [old_y_max_location_in_guess_2, old_x_max_location_in_guess_2] = find(ismember(Guess_region_2, max(Guess_region_2(:)))); %Finds the coordinates of the max in the region 
        old_y_max_location=old_y_max_location_in_guess_2+guess_lower_bound_in_y-1; %Taking the y-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
        old_x_max_location=old_x_max_location_in_guess_2+guess_lower_bound_in_x-1; %Taking the x-coordiantes of the maxima in the 2nd guess region and transform them into units of the 1st guess region
    
    end

diff_x=(desired_x-old_x_max_location); %Defining Difference between where the max is and where we want it to be in the x-direction
diff_y=(desired_y-old_y_max_location); %Defining Difference between where the max is and where we want it to be in the y-direction

Corrected_x_range=x-diff_x+999; %Transforms and corrects the location of the maxima such that the new range in x- draws a box in the proper area
Corrected_y_range=y-diff_y+999; %Transforms and corrects the location of the maxima such that the new range in y- draws a box in the proper are

    if smoothing_on_off == 1
        
        Final=Smoothed_master_array(Corrected_y_range,Corrected_x_range);
    
    elseif smoothing_on_off == 0
        
        Final=Unsmoothed_data(Corrected_y_range,Corrected_x_range);
    
    end

Guess_region_2=Final(475:525,475:525); %Specifying a region where the max should be for output purposes
[old_y_max_location, old_x_max_location] = find(ismember(Guess_region_2, max(Guess_region_2(:)))); %Finds the coordinates of the max in the region 
new_y_max_location=old_y_max_location+474; %Transforming back into units of the pinhole
new_x_max_location=old_x_max_location+474; %Transforming back into units of the pinhole


end

