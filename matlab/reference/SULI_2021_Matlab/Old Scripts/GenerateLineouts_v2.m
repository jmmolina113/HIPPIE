function [full_lineout,full_lineout2]=GenerateLineouts_v2(lineout,lineout2,error_pixels,Range)


% bckgrnd=background(lineout2); %Step 3
% [~,new_max]=max(lineout2);
% lineout2_n=lineout2(new_max:-1:(new_max-Range));%Step 4
% lineout2_n=lineout2_n-bckgrnd; %Step 5
% lineout2_n=FloorLineout(lineout2_n);
% norm=max(lineout2_n);
% lineout2_n=(1/norm)*lineout2_n; %Step 6
% 
% %normal process
% [~,new_max]=max(lineout);
% bckgrnd=background(lineout); %Step 3
% lineout_n=lineout(new_max:-1:(new_max-Range));%Step 4
% lineout_n=lineout_n-bckgrnd; %Step 5
% lineout_n=FloorLineout(lineout_n);
% norm=max(lineout_n);
% lineout_n=(1/norm)*lineout_n; %Step 6
% 
% 
% 
% %Upper Bound
% 
% [~,new_max]=max(lineout2);
% bckgrnd=background(lineout2); %Step 3
% lineout2_u=lineout2(new_max:-1:(new_max-Range));%Step 4
% lineout2_u=lineout2_u-bckgrnd; %Step 5
% lineout2_u=FloorLineout(lineout2_u);
% norm=max(lineout2_u);
% lineout2_u=(1/norm)*lineout2_u; %Step 6
% 
% 
% new_max=new_max+error_pixels;
% bckgrnd=background(lineout); %Step 3
% lineout_u=lineout(new_max:-1:(new_max-Range));%Step 4
% lineout_u=lineout_u-bckgrnd; %Step 5
% lineout_u=FloorLineout(lineout_u);
% norm=max(lineout_u);
% lineout_u=(1/norm)*lineout_u; %Step 6
% 
% 
% 
% 
% %Lower Bound
% 
% bckgrnd=background(lineout2); %Step 3
% lineout2_L=lineout2(new_max:-1:(new_max-Range));%Step 4
% lineout2_L=lineout2_L-bckgrnd; %Step 5
% lineout2_L=FloorLineout(lineout2_L);
% norm=max(lineout2_L);
% lineout2_L=(1/norm)*lineout2_L; %Step 6
% 
% 
% 
% [~,new_max]=max(lineout);
% new_max=new_max-error_pixels;
% bckgrnd=background(lineout); %Step 3
% lineout_L=lineout(new_max:-1:(new_max-Range));%Step 4
% lineout_L=lineout_L-bckgrnd; %Step 5
% lineout_L=FloorLineout(lineout_L);
% lineout_L=(1/norm)*lineout_L; %Step 6
% 
% 
% 
% 
% 
% %% Putting it all together
% 
% full_lineout=[lineout_u lineout_n lineout_L];
% full_lineout2=[lineout2_u lineout2_n lineout2_L];
% 
% full_lineout=smoothdata(full_lineout,'movmean',61);
% full_lineout2=smoothdata(full_lineout2,'movmean',61);




%%normal process
[~,new_max]=max(lineout);
bckgrnd=background(lineout); %Step 3
lineout_n=lineout(new_max:-1:(new_max-Range));%Step 4
lineout_n=lineout_n-bckgrnd; %Step 5
lineout_n=FloorLineout(lineout_n);
norm=max(lineout_n);
lineout_n=(1/norm)*lineout_n; %Step 6


bckgrnd=background(lineout2); %Step 3
%[~,new_max]=max(lineout2);
lineout2_n=lineout2(new_max:-1:(new_max-Range));%Step 4
lineout2_n=lineout2_n-bckgrnd; %Step 5
lineout2_n=FloorLineout(lineout2_n);
%norm=max(lineout2_n);
lineout2_n=(1/norm)*lineout2_n; %Step 6




%%Upper Bound

[~,new_max]=max(lineout);
new_max=new_max+error_pixels;
bckgrnd=background(lineout); %Step 3
lineout_u=lineout(new_max:-1:(new_max-Range));%Step 4
lineout_u=lineout_u-bckgrnd; %Step 5
lineout_u=FloorLineout(lineout_u);
norm=max(lineout_u);
lineout_u=(1/norm)*lineout_u; %Step 6

bckgrnd=background(lineout2); %Step 3
%[~,new_max]=max(lineout2);
lineout2_u=lineout2(new_max:-1:(new_max-Range));%Step 4
lineout2_u=lineout2_u-bckgrnd; %Step 5
lineout2_u=FloorLineout(lineout2_u);
lineout2_u=(1/norm)*lineout2_u; %Step 6



%%Lower Bound
[~,new_max]=max(lineout);
new_max=new_max-error_pixels;
bckgrnd=background(lineout); %Step 3
lineout_L=lineout(new_max:-1:(new_max-Range));%Step 4
lineout_L=lineout_L-bckgrnd; %Step 5
lineout_L=FloorLineout(lineout_L);
norm=max(lineout_L);
lineout_L=(1/norm)*lineout_L; %Step 6

bckgrnd=background(lineout2); %Step 3
%[~,new_max]=max(lineout2);
lineout2_L=lineout2(new_max:-1:(new_max-Range));%Step 4
lineout2_L=lineout2_L-bckgrnd; %Step 5
lineout2_L=FloorLineout(lineout2_L);
lineout2_L=(1/norm)*lineout2_L; %Step 6



%%% Putting it all together

full_lineout=[lineout_u lineout_n lineout_L];
full_lineout2=[lineout2_u lineout2_n lineout2_L];

end