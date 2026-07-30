function params=GrabParams(Date_Seq,Port)


id='MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id);
%Begin defining first input variable. 'j' will just pick out which column
%in the spreadsheet we want to look at

data=readtable('xray_params.xlsx','Format','auto'); %Read in data
table=table2cell(data); %Restructure data into something more useful


if Date_Seq=='180513_001'
    
    j=2;

elseif Date_Seq=='180513_002'
    
    j=3;
    
elseif Date_Seq=='180513_003'
    
    j=4;
    
elseif Date_Seq=='191113_003'
    
    j=5;
   
elseif Date_Seq=='191114_001'
    
    j=6;
    
elseif Date_Seq=='191114_002'
    
    j=7;
    
elseif Date_Seq=='201117_004'
    
    j=8;
    
elseif Date_Seq=='210317_001'
    
    j=9;
    
elseif Date_Seq=='210317_002'
    
    j=10;
    
end
%end of defining first input variable

%Begin putting all values from the Excel sheet into a stucture called "params"
params.expr=char(table(1,j)); 
params.date=str2double(table(2,j));
params.seq=str2double(table(3,j));
params.ints=str2double(table(4,j));
%Begin creating data for the first camera
params.cam1.port=char(table(6,j));
params.cam1.camera=char(table(7,j));
params.cam1.cal_cam=char(table(8,j));
params.cam1.cal_shot=char(table(9,j));
params.cam1.strip_dir=char(table(10,j));
params.cam1.t0=str2double(table(11,j));
params.cam1.mag=str2double(table(12,j));
params.cam1.dt=str2num(char(table(13,j)));
params.cam1.vpulse=str2double(table(14,j));
params.cam1.ccd_xwidth=str2double(table(15,j));
params.cam1.ccd_ywidth=str2double(table(16,j));
params.cam1.ang=str2double(table(17,j));
params.cam1.mirror=str2double(table(18,j));
params.cam1.npinholes=str2double(table(19,j));
params.cam1.nrow=str2double(table(20,j));
params.cam1.ncol=str2double(table(21,j));

%Begin carrying over each individual pinhole's data
p1=str2double(table(23,j));
p2=str2double(table(24,j));
p3=str2double(table(25,j));
p4=str2double(table(26,j));
p5=str2double(table(27,j));
p6=str2double(table(28,j));
p7=str2double(table(29,j));
p8=str2double(table(30,j));
p9=str2double(table(31,j));
p10=str2double(table(32,j));
p11=str2double(table(33,j));
p12=str2double(table(34,j));
p13=str2double(table(35,j));
p14=str2double(table(36,j));
p15=str2double(table(37,j));
p16=str2double(table(38,j));

if params.cam1.npinholes==12
    params.cam1.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12};
 
elseif params.cam1.npinholes==16
    params.cam1.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16};
end
params.cam1.pinholes=cell2table((params.cam1.pinholes));
%End of pinhole input

%Start of Filter Mat input
m1=convertCharsToStrings(char(table(40,j)));
m2=convertCharsToStrings(char(table(41,j)));
m3=convertCharsToStrings(char(table(42,j)));
m4=convertCharsToStrings(char(table(43,j)));
m5=convertCharsToStrings(char(table(44,j)));
m6=convertCharsToStrings(char(table(45,j)));
m7=convertCharsToStrings(char(table(46,j)));
m8=convertCharsToStrings(char(table(47,j)));
m9=convertCharsToStrings(char(table(48,j)));
m10=convertCharsToStrings(char(table(49,j)));
m11=convertCharsToStrings(char(table(50,j)));
m12=convertCharsToStrings(char(table(51,j)));
m13=convertCharsToStrings(char(table(52,j)));
m14=convertCharsToStrings(char(table(53,j)));
m15=convertCharsToStrings(char(table(54,j)));
m16=convertCharsToStrings(char(table(55,j)));

if params.cam1.npinholes==12
    params.cam1.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12};
 
elseif params.cam1.npinholes==16
    params.cam1.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15 m16};
end
params.cam1.filter_mat=cell2table((params.cam1.filter_mat));
%End of Filter Mat input

%Start of Filter Thick input
t1=str2double(table(57,j));
t2=str2double(table(58,j));
t3=str2double(table(59,j));
t4=str2double(table(60,j));
t5=str2double(table(61,j));
t6=str2double(table(62,j));
t7=str2double(table(63,j));
t8=str2double(table(64,j));
t9=str2double(table(65,j));
t10=str2double(table(66,j));
t11=str2double(table(67,j));
t12=str2double(table(68,j));
t13=str2double(table(69,j));
t14=str2double(table(70,j));
t15=str2double(table(71,j));
t16=str2double(table(72,j));

if params.cam1.npinholes==12
    params.cam1.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12};
 
elseif params.cam1.npinholes==16
    params.cam1.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16};
end
params.cam1.filter_thk=cell2table((params.cam1.filter_thk));
%End of Filter Thick input

%Same process but for the second camera in the data sheet
params.cam2.port=char(table(74,j));
params.cam2.camera=char(table(75,j));
params.cam2.cal_shot=str2double(table(76,j));
params.cam2.strip_dir=char(table(77,j));
params.cam2.t0=str2double(table(78,j));
params.cam2.mag=str2double(table(79,j));
params.cam2.dt=str2num(char(table(80,j))); %#ok<*ST2NM>
params.cam2.vpulse=str2double(table(81,j));
params.cam2.ccd_xwidth=str2double(table(82,j));
params.cam2.ccd_ywidth=str2double(table(83,j));
params.cam2.ang=str2double(table(84,j));
params.cam2.mirror=str2double(table(85,j));
params.cam2.npinholes=str2double(table(86,j));
params.cam2.nrow=str2double(table(87,j));
params.cam2.ncol=str2double(table(88,j));


%Start of pinhole
p1=str2double(table(90,j));
p2=str2double(table(91,j));
p3=str2double(table(92,j));
p4=str2double(table(93,j));
p5=str2double(table(94,j));
p6=str2double(table(95,j));
p7=str2double(table(95,j));
p8=str2double(table(96,j));
p9=str2double(table(97,j));
p10=str2double(table(98,j));
p11=str2double(table(99,j));
p12=str2double(table(100,j));
p13=str2double(table(101,j));
p14=str2double(table(102,j));
p15=str2double(table(103,j));
p16=str2double(table(104,j));

if params.cam2.npinholes==12
    params.cam2.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12};
 
elseif params.cam2.npinholes==16
    params.cam2.pinholes={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16};
    
elseif params.cam2.port=='N/A'
    params.cam2.pinholes={0};
end
params.cam2.pinholes=cell2table((params.cam2.pinholes));
%End of Pinhole

%Start of Filter Mat
m1=convertCharsToStrings(char(table(107,j)));
m2=convertCharsToStrings(char(table(108,j)));
m3=convertCharsToStrings(char(table(109,j)));
m4=convertCharsToStrings(char(table(110,j)));
m5=convertCharsToStrings(char(table(111,j)));
m6=convertCharsToStrings(char(table(112,j)));
m7=convertCharsToStrings(char(table(113,j)));
m8=convertCharsToStrings(char(table(114,j)));
m9=convertCharsToStrings(char(table(115,j)));
m10=convertCharsToStrings(char(table(116,j)));
m11=convertCharsToStrings(char(table(117,j)));
m12=convertCharsToStrings(char(table(118,j)));
m13=convertCharsToStrings(char(table(119,j)));
m14=convertCharsToStrings(char(table(120,j)));
m15=convertCharsToStrings(char(table(121,j)));
m16=convertCharsToStrings(char(table(122,j)));

if params.cam2.npinholes==12
    params.cam2.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12};
 
elseif params.cam2.npinholes==16
    params.cam2.filter_mat={m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15 m16};
    
elseif params.cam2.port=='N/A'
    params.cam2.filter_mat={0};
end
params.cam2.filter_mat=cell2table((params.cam2.filter_mat));
%End of Filter Mat

%Start of Filter Thick
t1=str2double(table(124,j));
t2=str2double(table(125,j));
t3=str2double(table(126,j));
t4=str2double(table(127,j));
t5=str2double(table(128,j));
t6=str2double(table(129,j));
t7=str2double(table(130,j));
t8=str2double(table(131,j));
t9=str2double(table(132,j));
t10=str2double(table(133,j));
t11=str2double(table(134,j));
t12=str2double(table(135,j));
t13=str2double(table(136,j));
t14=str2double(table(137,j));
t15=str2double(table(138,j));
t16=str2double(table(139,j));

if params.cam2.npinholes==12
    params.cam2.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12};
 
elseif params.cam2.npinholes==16
    params.cam2.filter_thk={t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16};
    
elseif params.cam2.port=='N/A'
    params.cam2.filter_thk={0};
end
params.cam2.filter_thk=cell2table((params.cam2.filter_thk));
%End of Filter Thick

if isequal(Port,params.cam1.port)
    params=params.cam1;
    
elseif isequal(Port,params.cam2.port)
    params=params.cam2;
    
else
    "Input port argument does not match a port used in this shot" %#ok<NOPRT>
end



end

