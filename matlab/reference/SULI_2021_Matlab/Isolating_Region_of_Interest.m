function [full_lineout,full_lineout2]=Isolating_Region_of_Interest(lineout,lineout2,error_pixels,Range)

%% Process w/o error
[~,new_max]=max(lineout); %Identifying the location of the max
bckgrnd=background(lineout); %Calculating the Background
lineout_n=lineout(new_max:-1:(new_max-Range));%Isolating the Region of Interest
lineout_n=lineout_n-bckgrnd; %Background subtraction
lineout_n=FloorLineout(lineout_n); %Flooring the < 0 values
norm=max(lineout_n); %Identifying the value of the max
lineout_n=(1/norm)*lineout_n; %Normalizing 

%These steps will be the same the entire way through


bckgrnd=background(lineout2); 
%[~,new_max]=max(lineout2);

lineout2_n=lineout2(new_max:-1:(new_max-Range)); %This is a possible point of error. It is hard to say where to draw the lineouts
%after aligned. There is no point in the area alignment if we draw them at
%the individual maxes of each lineout. Using the max of the high signal
%lineout works well for me and got good answers. It is hard to say
%though...I tried the max of the low signal lineout and that did not work well, as well as the 
%mean of the location of the two maxes and that didn't work well either.


lineout2_n=lineout2_n-bckgrnd; 
lineout2_n=FloorLineout(lineout2_n);
%norm=max(lineout2_n);
lineout2_n=(1/norm)*lineout2_n; 

%% Upper error bound calculation

[~,new_max]=max(lineout);
new_max=new_max+error_pixels;
bckgrnd=background(lineout); 
lineout_u=lineout(new_max:-1:(new_max-Range));
lineout_u=lineout_u-bckgrnd; 
lineout_u=FloorLineout(lineout_u);
norm=max(lineout_u);
lineout_u=(1/norm)*lineout_u; 

bckgrnd=background(lineout2);
%[~,new_max]=max(lineout2);
lineout2_u=lineout2(new_max:-1:(new_max-Range));
lineout2_u=lineout2_u-bckgrnd; 
lineout2_u=FloorLineout(lineout2_u);
lineout2_u=(1/norm)*lineout2_u; 

%% Lower Bound
[~,new_max]=max(lineout);
new_max=new_max-error_pixels;
bckgrnd=background(lineout); 
lineout_L=lineout(new_max:-1:(new_max-Range));
lineout_L=lineout_L-bckgrnd;
lineout_L=FloorLineout(lineout_L);
norm=max(lineout_L);
lineout_L=(1/norm)*lineout_L; 

bckgrnd=background(lineout2); 
%[~,new_max]=max(lineout2);
lineout2_L=lineout2(new_max:-1:(new_max-Range));
lineout2_L=lineout2_L-bckgrnd; 
lineout2_L=FloorLineout(lineout2_L);
lineout2_L=(1/norm)*lineout2_L; 

%% Putting it all together

full_lineout=[lineout_u lineout_n lineout_L];
full_lineout2=[lineout2_u lineout2_n lineout2_L];


end