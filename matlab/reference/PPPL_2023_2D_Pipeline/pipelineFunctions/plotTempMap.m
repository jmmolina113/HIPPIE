function plotTempMap(tempLength,Te,coloBarLimit)

figure()
% surf(tempLength,tempLength,Te)
surf(Te)

shading interp
clbr=colorbar;
clbr.Label.String="Temperature (eV)";
xlabel("Length [mm]",'FontSize',24)
ylabel("Length [mm]",'FontSize',24)
% xlim([0 tempLength(end)])
% ylim([0 tempLength(end)/2+1])
view(2)
caxis([0 coloBarLimit]) %Setting the color bar limits
set(gca,'linewidth',2)
set(gca,'fontsize',24)
title("Temperature Map")
grid off


end