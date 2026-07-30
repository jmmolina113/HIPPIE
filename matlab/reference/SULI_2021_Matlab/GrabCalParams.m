
function cal_params=GrabCalParams(Date_Seq)

id='MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id);
%Begin defining first input variable. 'j' will just pick out which column
%in the spreadsheet we want to look at

if Date_Seq=='130319_002'
    
    j=2;

elseif Date_Seq=='140515_004'
    
    j=3;
    
elseif Date_Seq=='140627_001'
    
    j=4;
    
elseif Date_Seq=='180916_003'
    
    j=5;
   
elseif Date_Seq=='180916_003'
    
    j=6;
    
elseif Date_Seq=='180917_001'
    
    j=7;
    
elseif Date_Seq=='180917_002'
    
    j=8;
    
elseif Date_Seq=='191110_002'
    
    j=9;
    
end


data=readtable('cal_params.xlsx','Format','auto'); %Read in data
table=table2cell(data); %Restructure data into something more useful

%Begin putting all values from the Excel sheet into a stucture called "cal_params"
cal_params.date=str2double(table(1,j));
cal_params.seq=str2double(table(2,j));
cal_params.port=char(table(3,j));
cal_params.camera=char(table(4,j));
cal_params.strip_dir=char(table(5,j));
cal_params.volt=str2num(char(table(6,j)));
cal_params.dt=str2num(char(table(7,j)));
cal_params.vpulse=str2double(table(8,j));
cal_params.ccd_xwidth=str2double(table(9,j));
cal_params.ccd_ywidth=str2double(table(10,j));
cal_params.mirror=str2double(table(11,j));

end

