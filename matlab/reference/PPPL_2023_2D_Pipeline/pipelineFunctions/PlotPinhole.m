function PlotPinhole(Data)

figure()
mesh(Data)
colorbar
caxis([0 1200]) %Setting the color bar limits
view(2)
xlim([0 size(Data,2)])
ylim([0 size(Data,1)])
grid off
end