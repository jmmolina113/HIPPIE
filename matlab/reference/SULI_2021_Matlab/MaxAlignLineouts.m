function [lineout_x,lineout_y]=MaxAlignLineouts(max_x,max_y,desired_max_x,desired_max_y,average_pixels,Final)

avg_range_x=[(max_x-average_pixels):1:(max_x+average_pixels)]; %Defining perpendicular range to average over 
avg_range_y=[(max_y-average_pixels):1:(max_y+average_pixels)]; %Defining perpendicular range to average over
lineout_x=mean(Final(avg_range_y,:)); %Creating the lineout
lineout_y=mean(Final(:,avg_range_x),2); %Creating the lineout



[~, avg_max_x] = find(ismember(lineout_x, max(lineout_x((max_x-100):(max_x+100))))); %Identifying the maxima
[avg_max_y,~] = find(ismember(lineout_y, max(lineout_y((max_y-100):(max_y+100))))); %Identifying the maxima

diff_x=desired_max_x-avg_max_x; %Calculating the difference in the desired max and where it actually is
diff_y=desired_max_y-avg_max_y; %Calculating the difference in the desired max and where it actually is

X=NaN(2000,1); %Creating an array of NaN values to imbed the lineouts so we can shift them around
Y=NaN(2000,1); %Creating an array of NaN values to imbed the lineouts so we can shift them around

range=101:1151;
X(range)=lineout_x; %Imbedding the lineout in the NaN array
Y(range)=lineout_y; %Imbedding the lineout in the NaN array

R_x=range-diff_x; %Shifting the lineout range
R_y=range-diff_y; %Shifting the lineout range


%The following conditional statements just give the bounds a little nudge
%in case we attempt to shift by more than the size of range. Doesn't always
%happen but really just serves to prevent the code from erroring out and
%doens't matter much because we end up aligning things agian anyways 

if min(R_x) < 0
    
   R_x=R_x-min(R_x)+1;
   
end

if min(R_y) < 0
    
   R_y=R_y-min(R_y)+1;
   
end

lineout_x=X(R_x); %Max-aligned lineout
lineout_y=Y(R_y); %Max-aligned lineout


end