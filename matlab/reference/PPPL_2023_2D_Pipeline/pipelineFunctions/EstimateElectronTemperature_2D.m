function [Te,targetEdge]=EstimateElectronTemperature_2D(shotLocation,calLocation,shotSeqPort,parametersLocation,whereToLook,pinholeToUse,whereToPlaceMax,filterDataLocation,smoothPixels,binSize,floorValue,howToBin,tempBound);

%% Experimental Analysis
smoothing_type='movmean'; %Defining the method we want to use when we smooth over our pinhole

params=GrabParams_v4(shotSeqPort,parametersLocation); %arg(GrabParams)=(ShotDate_ShotSeq,port)

Perp_Range=RealUnits2Pixels((0.3)/2,params); %How far out in the direction perpendicular to the lineout we want to averge

[S_total,didSwitch,targetEdge]=PinholeAnalysis_2D(shotLocation,calLocation,parametersLocation,shotSeqPort,pinholeToUse(1),pinholeToUse(2),(pinholeToUse(2)+1),smoothing_type,smoothPixels,whereToLook,flip(whereToPlaceMax),Perp_Range,binSize,floorValue,howToBin,params);

%final_lineout_error=lineout_error(S); %Calculating the error in the lineouts

S=S_total(:,:,1);


%% Theoretical Analysis

[R]=theoreticalAnalysis_2D(pinholeToUse(1),pinholeToUse(2),(pinholeToUse(2)+1),filterDataLocation,didSwitch,params);

%% Temperature Calculation

Te(:,:,1)=calculateTemperature(R(:,2),S_total(:,:,1),tempBound); %Temperature Calculation w/o Error
Te(:,:,2)=calculateTemperature(R(:,1),S_total(:,:,2),tempBound); %Temperature Calculation: upper bound on horizontal
Te(:,:,3)=calculateTemperature(R(:,3),S_total(:,:,3),tempBound); %Temperature Calculation: lower bound on horizontal
Te(:,:,4)=calculateTemperature(R(:,1),S_total(:,:,4),tempBound); %Temperature Calculation: upper bound on vertical
Te(:,:,5)=calculateTemperature(R(:,3),S_total(:,:,5),tempBound); %Temperature Calculation: lower bound on vertical


end


