function [Lineout_Y]=Generate_and_Align_Lineouts(RawData1,RawData2,pixel_average,max_x,max_y,max_x2,max_y2)

[~,lineout1_y]=MaxAlignLineouts(max_x,max_y,500,500,pixel_average,RawData1); %Takes in pinhole 1 and spits out lineouts aligned at pixel=500
[~,lineout2_y]=MaxAlignLineouts(max_x2,max_y2,500,500,pixel_average,RawData2); %Takes in pinhole 2 and spits out lineouts aligned at pixel=500
    
% [lineout1_x,lineout2_x]=AlignArea(lineout1_x,lineout2_x); 
%This ^^^ is commented out because I never used the horizontal lineouts

[lineout1_y,lineout2_y]=AlignArea(lineout1_y,lineout2_y); %Aligns two 
%lineouts by holding one in place and shifting the other so as to minimize
%the area enclosed by the two of them


%Lineout_X=[lineout1_x lineout2_x];
%This ^^^ is commented out because I never used the horizontal lineouts

Lineout_Y=[lineout1_y lineout2_y]; %Area-aligned lineouts



end
