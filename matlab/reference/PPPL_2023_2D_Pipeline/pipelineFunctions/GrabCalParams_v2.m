
function cal_params=GrabCalParams_v2(Date_Seq,parametersLocation)

id='MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id);
%Begin defining first input variable. 'j' will just pick out which column
%in the spreadsheet we want to look at

fileName='cal_params_final.xlsx';

fileLocationAndName=strcat(parametersLocation,fileName);
data=readtable(fileLocationAndName,'Format','auto'); %Read in data
table=table2cell(data); %Restructure data into something more useful


for i=1:size(table,2) 

    if isequal(char(table(1,i)),Date_Seq)==1
        j=i;
    end
    
end

%Begin putting all values from the Excel sheet into a stucture called "cal_params"
cal_params.date=str2double(table(2,j));
cal_params.seq=str2double(table(3,j));
cal_params.port=char(table(4,j));
cal_params.camera=char(table(5,j));
cal_params.strip_dir=char(table(6,j));
cal_params.volt=str2num(char(table(7,j)));
cal_params.dt=str2num(char(table(8,j)));
cal_params.vpulse=str2double(table(9,j));
cal_params.ccd_xwidth=str2double(table(10,j));
cal_params.ccd_ywidth=str2double(table(11,j));
cal_params.mirror=str2double(table(12,j));

end

