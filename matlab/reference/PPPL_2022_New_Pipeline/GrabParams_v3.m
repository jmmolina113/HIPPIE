function params=GrabParams_v3(Date_Seq_Port)


id='MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id);

data=readtable('HIPPIE_DATA_ROOT','Format','auto'); %Read in data
table=table2cell(data); %Restructure data into something more useful

%The loop below is method of picking out which shot we want to look at.
%it will loop through all the Date_Seq_Ports until it finds the one you
%specify in the input function and ID the column of data to use based on
%where the correct Date_Seq_Port was

for i=1:size(table,2) 

    if isequal(char(table(1,i)),Date_Seq_Port)==1
        j=i;
    end
    
end


%Begin putting all values from the Excel sheet into a stucture called "params"
params.expr=char(table(1,j)); 
params.date=str2double(table(2,j));
params.seq=str2double(table(3,j));
params.port=char(table(4,j));
params.camera=char(table(5,j));
params.ints=str2double(table(6,j));
params.cal_cam=char(table(7,j));
params.cal_shot=char(table(8,j));
params.strip_dir=char(table(9,j));
params.t0=str2double(table(10,j));
params.mag=str2double(table(11,j));
params.dt=str2num(char(table(12,j)));
params.vpulse=str2double(table(13,j));
params.ccd_xwidth=str2double(table(14,j));
params.ccd_ywidth=str2double(table(15,j));
params.ang=str2double(table(16,j));
params.mirror=str2double(table(17,j));
params.npinholes=str2double(table(18,j));
params.nrow=str2double(table(19,j));
params.ncol=str2double(table(20,j));

%Begin carrying over each individual pinhole's data

index=22;
while ((isnan(str2double(table(index,j)))~=1))

    temporary_filter_matrix{index-21}=str2double(table(index,j));
    index = index + 1;

end

params.pinholes=cell2table((temporary_filter_matrix));
%End of pinhole input

%Start of Filter Mat input

index=39;
while (convertCharsToStrings(char(table(index,j)))~="")

    temporary_filter_matrix{index-38}=convertCharsToStrings(char(table(index,j)));
    index = index + 1;

end

params.filter_mat=cell2table((temporary_filter_matrix));

%End of Filter Mat input

%Start of Filter Thick input


for index=[56:size(data,1)];

    temporary_filter_matrix{index-55}=str2num(char(table(index,j)));

end
params.filter_thk=cell2table(temporary_filter_matrix);

%End of Filter Thick input

end

