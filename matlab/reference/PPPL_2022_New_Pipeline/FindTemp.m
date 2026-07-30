function [T]=FindTemp(Ratio,Signal_Ratio,Temps)

[~, index] = min(abs(Ratio-(Signal_Ratio)));

T=Temps(index);

end