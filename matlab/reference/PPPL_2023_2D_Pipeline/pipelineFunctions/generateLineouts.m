function [lineout1_final,lineout2_final]=generateLineouts(pinhole1,pinhole2,pixelAverage,paraRange,params,netShiftVert)


lineout1=mean(pinhole1(:,(500-pixelAverage):(500+pixelAverage)),2,"omitnan");
lineout2=mean(pinhole2(:,(500-pixelAverage):(500+pixelAverage)),2,"omitnan");
replacement=filloutliers(normalize(lineout2),'linear','movmean',5);


% figure()
% plot(normalize(lineout1),'b-','LineWidth',2.5)
% hold on
% plot(normalize(lineout2),'r-','LineWidth',2.5)
% % hold on
% % plot(replacement,'g--','LineWidth',1.5)
% title("Lineouts to Use")
% legend("Pinhole 1","Pinhole 2")

 %[lineout1_final,lineout2_final]=isolateRegionOfInterest(lineout1,lineout2,RealUnits2Pixels(0.05,params),paraRange);
[lineout1_final,lineout2_final]=isolateRegionOfInterest(lineout1,lineout2,netShiftVert,paraRange);


physicalRange=(1.5/length(lineout1_final(:,2)))*([0:length(lineout1_final(:,2))-1]);

figure()
plot(physicalRange,lineout1_final(:,2),'b-','LineWidth',2.5)
hold on
plot(physicalRange,lineout2_final(:,2),'r-','LineWidth',2.5)
xlabel("Distance from Plasma Maxima [mm]")
ylabel("Arb.")
title("Isolated Region of Interest")
legend("Pinhole 1","Pinhole 2")
set(gca, 'YScale', 'log')

figure()
plot(physicalRange,lineout2_final(:,2)./lineout1_final(:,2),'b-','LineWidth',2.5)
hold on
plot(physicalRange,mean(lineout2_final(:,2)./lineout1_final(:,2))*(zeros(1,length(physicalRange))+1),'r--','LineWidth',2.5)
legend("Signal Ratio","Mean Signal Ratio")
xlabel("Distance from Plasma Maxima [mm]")
ylabel("Signal Ratio (S) [Unitless]")
title("Ratio of Lineouts")

% 
% 
% replacement=filloutliers(1/(max(gradient(lineout2)))*gradient(lineout2),'nearest','mean');
% figure()
% plot(1/(max(gradient(lineout2)))*gradient(lineout2),'r-','LineWidth',2.5)
% hold on
% plot(replacement,'g--','LineWidth',1.5)
% %plot(normalize(lineout2),'r--','LineWidth',1.5)
% 
% 
% outlierLocation=isoutlier(gradient(lineout2),'mean');
% 
% internalIndex=1;
% for i=1:length(lineout2)
%     if outlierLocation(i)==1
%         
%         isolatedIndex(internalIndex)=i;
%         internalIndex=internalIndex+1;
% 
%     end
% end
% 
% lineout2_filtered=lineout2;
% 
% 
% 
% for i=1:length(isolatedIndex)
%     
%     range=(isolatedIndex(i)-6:isolatedIndex(i)-1);
%     lineout2_filtered(isolatedIndex(i))=interp1(range,lineout2_filtered(range),(isolatedIndex(i)),'pchip');
% 
% end
% 
% figure()
% plot(1/(max(gradient(lineout2)))*gradient(lineout2),'r-','LineWidth',2.5)
% hold on
% plot(1/(max(gradient(lineout2_filtered)))*gradient(lineout2_filtered),'g--','LineWidth',1.5)




