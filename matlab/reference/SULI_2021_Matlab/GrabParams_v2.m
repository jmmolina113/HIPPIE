function params=GrabParams_v2(Date_Seq_Port)


id='MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id);

data=readtable('xray_params.xlsx','Format','auto'); %Read in data
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
p1=str2double(table(22,j));
p2=str2double(table(23,j));
p3=str2double(table(24,j));
p4=str2double(table(25,j));
p5=str2double(table(26,j));
p6=str2double(table(27,j));
p7=str2double(table(28,j));
p8=str2double(table(29,j));
p9=str2double(table(30,j));
p10=str2double(table(31,j));
p11=str2double(table(32,j));
p12=str2double(table(33,j));
p13=str2double(table(34,j));
p14=str2double(table(35,j));
p15=str2double(table(36,j));
p16=str2double(table(37,j));


%Below is my method for putting everything into an array...this could definitely be improved to accomodate arbitrary pinhole sizes
if params.npinholes==12
    params.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12};
 
elseif params.npinholes==16
    params.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16};
end
params.pinholes=cell2table((params.pinholes));
%End of pinhole input

%Start of Filter Mat input
m1=convertCharsToStrings(char(table(39,j)));
m2=convertCharsToStrings(char(table(40,j)));
m3=convertCharsToStrings(char(table(41,j)));
m4=convertCharsToStrings(char(table(42,j)));
m5=convertCharsToStrings(char(table(43,j)));
m6=convertCharsToStrings(char(table(44,j)));
m7=convertCharsToStrings(char(table(45,j)));
m8=convertCharsToStrings(char(table(46,j)));
m9=convertCharsToStrings(char(table(47,j)));
m10=convertCharsToStrings(char(table(48,j)));
m11=convertCharsToStrings(char(table(49,j)));
m12=convertCharsToStrings(char(table(50,j)));
m13=convertCharsToStrings(char(table(51,j)));
m14=convertCharsToStrings(char(table(52,j)));
m15=convertCharsToStrings(char(table(53,j)));
m16=convertCharsToStrings(char(table(54,j)));

if params.npinholes==12
    params.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12};
 
elseif params.npinholes==16
    params.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15 m16};
end
params.filter_mat=cell2table((params.filter_mat));
%End of Filter Mat input

%Start of Filter Thick input
t1=str2double(table(56,j));
t2=str2double(table(57,j));
t3=str2double(table(58,j));
t4=str2double(table(59,j));
t5=str2double(table(60,j));
t6=str2double(table(61,j));
t7=str2double(table(62,j));
t8=str2double(table(63,j));
t9=str2double(table(64,j));
t10=str2double(table(65,j));
t11=str2double(table(66,j));
t12=str2double(table(67,j));
t13=str2double(table(68,j));
t14=str2double(table(69,j));
t15=str2double(table(70,j));
t16=str2double(table(71,j));

if params.npinholes==12
    params.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12};
 
elseif params.npinholes==16
    params.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16};
end
params.filter_thk=cell2table((params.filter_thk));
%End of Filter Thick input

end

