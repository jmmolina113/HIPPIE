function processedPinhole=processPinholes(inputPinhole,maximaCoords,floorValue)
% This function performs all the nessecary processing for a given pinhole
% so that is is ready for us to analyze

background=background_2D(inputPinhole,maximaCoords); %Calculating the Background
pinhole_b=inputPinhole-background; %Back ground subtraction
pinhole_bf=floorPinhole_2D(pinhole_b,floorValue); %Flooring the < 0 values

processedPinhole=pinhole_bf; %Pinhole to output

end