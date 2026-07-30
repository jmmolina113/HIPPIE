function [lineout_x,lineout_y]=GenerateLineouts(max_x,max_y,average_pixels,Final)
% 
avg_range_x=[(max_x-average_pixels):1:(max_x+average_pixels)];
avg_range_y=[(max_y-average_pixels):1:(max_y+average_pixels)];
% avg_range_x=[(max_x-average_pixels):1:(max_x)];
% avg_range_y=[(max_y-average_pixels):1:(max_y)];
lineout_x=mean(Final(avg_range_x,:));
lineout_y=mean(Final(:,avg_range_y),2);


end