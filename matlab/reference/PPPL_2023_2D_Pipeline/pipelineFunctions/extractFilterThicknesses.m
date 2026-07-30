function [filterThickness1,filterThickness2]=extractFilterThicknesses(params,row,column)

%This code is used to automatically extract the filter thicknesses form the
%x-ray params excel sheet. 
    
    valueToSelect=(4-row)*4+column; %converting the (row,column) identifier method into the coordinate scheme of the excel sheet
    
    filterThickness=table2array(params.filter_thk(1,valueToSelect)); %extracting the filter thicknesses from the params file
    
    if length(filterThickness)==1 %how to deal with a single filter material
    
        filterThickness1=filterThickness;
        filterThickness2=0;
    
    elseif length(filterThickness)==2 %how to deal with two filter materials
    
        filterThickness1=filterThickness(1);
        filterThickness2=filterThickness(2);
    
    else %safe gaurd against > 2 filter matierals
    
        error("Too many filters. Readjust extractFilterThicknesses.m");
    end




end