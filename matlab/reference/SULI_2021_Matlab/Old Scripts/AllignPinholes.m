function [Data1, Data2]=AllignPinholes(RawData1,RawData2,pixel_average,max_x,max_y,max_x2,max_y2)

A=NaN(4000,4000);
range=801:1851;
A(range,range)=RawData2;

[lineout1_x,lineout1_y]=MaxAlignLineouts(max_x,max_y,500,500,pixel_average,RawData1);
[lineout2_x,lineout2_y]=MaxAlignLineouts(max_x2,max_y2,500,500,pixel_average,RawData2);

[shift_x]=AlignArea_v2(lineout2_x,lineout1_x);
[shift_y]=AlignArea_v2(lineout2_y,lineout1_y);

% Data1=A((range-shift_y),(range-shift_x));
% Data2=RawData2;

Data2=A((range-shift_y),(range-shift_x));
Data1=RawData1;





end
