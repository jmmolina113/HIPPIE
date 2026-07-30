function [corrected,new_max]=AlignGradient(centered_lineout,allignment_point)

A=NaN(2000,1);
range=401:1451;
A(range)=centered_lineout;

g=gradient(centered_lineout);
g=smoothdata(g,'movmean',61);
%g=abs(g);



% if abs(min(g)) > max(g)
% 
%     [x_coordinate, blank] = find(ismember(g, max(g(100:800)))); %Finds the coordinates of the max in the region 
% 
% elseif max(g) > abs(min(g)) 
% 
%     [x_coordinate, blank] = find(ismember(g, min(g(100:800)))); %Finds the coordinates of the max in the region 
% 
% 
% end

[x_coordinate, ~] = find(ismember(g, max(g(300:650)))); %Finds the coordinates of the max in the region 

%[x_coordinate, blank] = find(ismember(g, min(g(100:800)))); %Finds the coordinates of the max in the region 


diff=allignment_point-x_coordinate;

corrected=A(range-diff);

g2=gradient(corrected);
[new_max, ~] = find(ismember(g2, min(g2(300:650)))); %Finds the coordinates of the max in the region 


end