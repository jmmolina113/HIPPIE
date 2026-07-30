function [energyData,transmissionCurve_full]=calculateTransmissionCurves(filterFileName1,filterFileName2,filterThickness1,filterThickness2)
%This function, given filter file name and thickness data, will extract
%the appropriate transmission curves for a given pinhole.
    
    if filterFileName2==0 %For a single filter, the process is straight forward and what GetFilterTransmission 
        %returns is the appropriate result
    
        [energyData,transmissionCurve_full]=GetFilterTransmission_v2(filterFileName1,filterThickness1,0.1);
    
    else %Otherwise, for more than 1 filter on a given pinhole
        %you need to add the transmission curves appropriately 
    
        [energyData,transmissionCurve1_full]=GetFilterTransmission_v2(filterFileName1,filterThickness1,0.1);
        [~,transmissionCurve2_full]=GetFilterTransmission_v2(filterFileName2,filterThickness2,0.1);
    
        transmissionCurve_full=transmissionCurve1_full.*transmissionCurve2_full; %Combining the two transmission curves for a given pinhole
    
    end



end