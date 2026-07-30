function [ycoordinate, xcoordinate]=FindMax(Data)
% 
% if location==-1
%     Guess=Data(450:600,450:600);
%     [ycoordinate, xcoordinate] = find(ismember(Guess, max(Guess(:)))); %Finds the coordinates of the max in the region 
%     ycoordinate=ycoordinate+449;
%     xcoordinate=xcoordinate+449;
% 
% elseif location==0
%     
%     Guess=Data(450:600,450:600);
%     [ycoordinate, xcoordinate] = find(ismember(Guess, max(Guess(:)))); %Finds the coordinates of the max in the region 
%     ycoordinate=ycoordinate+449;
%     xcoordinate=xcoordinate+449;
%     
% elseif ocation==1
% end


    Guess=Data(450:600,450:600);
    [ycoordinate, xcoordinate] = find(ismember(Guess, max(Guess(:)))); %Finds the coordinates of the max in the region 
    ycoordinate=ycoordinate+449;
    xcoordinate=xcoordinate+449;



end