function [Lineout_Y]=AllignPinholes_v2(RawData1,RawData2,pixel_average,max_x,max_y,max_x2,max_y2)
%[Lineout_X, Lineout_Y]=AllignPinholes_v2(RawData1,RawData2,pixel_average,max_x,max_y,max_x2,max_y2)

A=NaN(4000,4000);
range=801:1851;
A(range,range)=RawData1;

[~,lineout1_y]=MaxAlignLineouts(max_x,max_y,500,500,pixel_average,RawData1);
[~,lineout2_y]=MaxAlignLineouts(max_x2,max_y2,500,500,pixel_average,RawData2);


T=[1:1051];
figure()
curve1 = (normalize(lineout1_y))';
curve2 = (normalize(lineout2_y))';
plot(T, curve2, 'b', 'LineWidth', 2);
x1 = [T, fliplr(T)];
inBetween = [curve1, fliplr(curve2)];
fill(x1, inBetween,'g');
hold on
plot(normalize(lineout1_y),'b','LineWidth',2)
hold on
plot(normalize(lineout2_y),'r','LineWidth',2)
% lineout1_y=smoothdata(lineout1_y,'movmean',200);
% lineout2_y=smoothdata(lineout2_y,'movmean',200);
legend('','Low Filtered Pinhole','High Filtered Pinhole')
xlabel('Pixels')
ylabel('Signal (Arb.)')
title('Unaligned')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
% 
% H=gca;
% H.LineWidth=2; %change to the desired value     

figure()
plot(normalize(lineout1_y),'b','LineWidth',2)
hold on
plot(normalize(lineout2_y),'r','LineWidth',2)
%title('Normalized + Max Aligned Lineouts')
legend('Low Filtered Pinhole','High Filtered Pinhole')
xlabel('Pixels')
ylabel('Signal (Arb.)')
title('Unaligned')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
% [lineout1_x,lineout2_x]=AlignArea(lineout1_x,lineout2_x);
[lineout1_y,lineout2_y]=AlignArea(lineout1_y,lineout2_y);
figure()
plot(normalize(lineout1_y),'b','LineWidth',2)
hold on
plot(normalize(lineout2_y),'r','LineWidth',2)
title('Aligned')
legend('Low Filtered Pinhole','High Filtered Pinhole')
xlabel('Pixels')
ylabel('Signal (Arb.)')
set(gca,'FontSize',35)
set(gca,'LineWidth',2)
% [lineout2_x,lineout1_x]=AlignArea(lineout2_x,lineout1_x);
[lineout2_y,lineout1_y]=AlignArea(lineout2_y,lineout1_y);

%Lineout_X=[lineout1_x lineout2_x];

Lineout_Y=[lineout1_y lineout2_y];



end
