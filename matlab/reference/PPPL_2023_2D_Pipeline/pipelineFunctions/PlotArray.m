function PlotArray(Data)

figure()
mesh(Data)
colorbar
caxis([0 1200]) %Setting the color bar limits
view(2)
xlim([0 4200])
ylim([0 4200])
grid off

end