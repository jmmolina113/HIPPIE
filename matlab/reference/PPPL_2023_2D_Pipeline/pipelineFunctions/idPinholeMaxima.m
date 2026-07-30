function coords=idPinholeMaxima(pinhole,whereToLook)
%This function locates the maxima of a given pinhole image of arbitrary
%size

if whereToLook==-1 || whereToLook==1

    length=size(pinhole,1); %Extractig the length of the image
    width=size(pinhole,2); %Extractig the width of the image

    [~,xCoord]=max(max(pinhole(length/2-10:length/2+10,width/2-10:width/2+25))); %Isolating the x-coordinate of the maxaima
    xCoord=round(xCoord+width/2-10); %Transforming above line into the image space of the full pinhole

    [~,yCoord]=max(pinhole(:,xCoord)); %Isolating the y-coordinate of the maxaima

    
    coords=[yCoord, xCoord];


elseif whereToLook==0


    length=size(pinhole,1); %Extractig the length of the image
    width=size(pinhole,2); %Extractig the width of the image

    [~,xCoord]=max(max(pinhole(length/2-25:length/2+25,width/2-50:width/2+50))); %Isolating the x-coordinate of the maxaima
    xCoord=round(xCoord+width/2-50); %Transforming above line into the image space of the full pinhole

    [~,yCoord]=max(pinhole(:,xCoord)); %Isolating the y-coordinate of the maxaima

    
    coords=[yCoord, xCoord];
    %coords=[500 500];


end




end