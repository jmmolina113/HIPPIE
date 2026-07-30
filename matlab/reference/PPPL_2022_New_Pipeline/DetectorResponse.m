function K=DetectorResponse(energy)
% 
K=zeros(size(energy,1),1);

for i=1:size(energy,1)

    if (energy(i) >= 10) && (energy(i) < 600)
    
     K(i)= 40*(10)^(1/4)*exp(-energy(i)*log(10)/480);
    
    elseif (energy(i) >= 600) && (energy(i) <= 1800)
    
     K(i)= 10*(10)^(1/2)*exp(-energy(i)*log(10)/1200);
    
    
    elseif (energy(i) < 10)
    
     K(i)=1;
    
    elseif (energy(i) > 1800)
    
     K(i)=1;
    
    
    end


end
% data=readtable('ResponseFunction.xlsx','Format','auto'); %Read in data
% data=table2array(data); %Restructure data into something more useful
% X=data(:,1);
% Y=data(:,2);
% % 
% % figure()
% % plot(X,Y)
% % hold on
% % plot(energy,K)
% % set(gca, 'YScale', 'log')
% % ylim([0.01 100])
% % xlim([-500 10000])
% % 
% % 
% 
% K=interp1(X,Y,energy);
% K(1)=10;
% K(2)=10;
% K(51:end)=0.2;


end
