function PlotPinhole(Data)

figure()
mesh(Data)
colorbar
caxis([0 1200]) %Setting the color bar limits
view(2)
xlim([0 1051])
ylim([0 1051])
grid off
end