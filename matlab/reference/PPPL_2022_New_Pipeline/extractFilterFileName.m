function [filterFileName1,filterFileName2]=extractFilterFileName(params,row,column,filterDataLocation)

    %This code is used to automatically extract and construct the filter material/file names form the
    %x-ray params excel sheet. 
    
    valueToSelect=(4-row)*4+column; %converting the (row,column) identifier method into the coordinate scheme of the excel sheet
    
    filterMaterial=table2array( params.filter_mat(1,valueToSelect)); %extracting the filter thicknesses from the params file
    filterMaterial=split(filterMaterial,',');
    
    if length(filterMaterial)==1 %how to deal with a single filter material
    
        stringToJoin=[filterDataLocation filterMaterial(1) "_10.txt"];
        filterFileName1=strjoin(stringToJoin,'');
        filterFileName2=0;
    
    elseif length(filterMaterial)==2 %how to deal with two filter materials
    
        stringToJoin=[filterDataLocation filterMaterial(1) "_10.txt"];
        filterFileName1=strjoin(stringToJoin,'');

        stringToJoin=[filterDataLocation filterMaterial(2) "_10.txt"];
        filterFileName2=strjoin(stringToJoin,'');
    
    else %safe gaurd against > 2 filter matierals
    
        error("Too many filters. Readjust extractFilterFileName.m");
    end

end