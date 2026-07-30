function bckgrnd=background(lineout)

[~,index]=max(isnan(lineout(500:end)));

if index == 1
    
    index=1051;
    
else
    
index=index+499;

end

% if index==1
%     
%     index=1051;
%     
% end

bckgrnd=mean(lineout((index-1-10):(index-1)));


end