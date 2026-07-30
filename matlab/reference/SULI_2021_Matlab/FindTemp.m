function [T,Location]=FindTemp(Ratio,Signal_Ratio,Temps,params)

% M=zeros(size(Ratio,1),size(Signal_Ratio,1));

% for i=1:size(Ratio,2)
% 
%     for j=1:size(Signal_Ratio,1)
%         
%     M(i,j)=Ratio(i)-Signal_Ratio(j);
%     
%    
%     
%     end
% end

[min_value, index] = min(abs(Ratio-(Signal_Ratio)));
% [min_row,min_col]=find(ismember(abs(M), min(abs(M(:)))));

T=Temps(index);

Location=index+500; %mm


end