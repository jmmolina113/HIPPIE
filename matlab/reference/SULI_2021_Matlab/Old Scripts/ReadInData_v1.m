clear all


params=GrabParams('180513_001');
params_cam1=params.cam1
params_cam2=params.cam2

function params=GrabParams(Date_Seq)

if Date_Seq=='180513_001'
    
    j=2;

elseif Date_Seq=='180513_002'
    
    j=3;
end


data=readtable('xray_params.xlsx','Format','auto');
table=table2cell(data);
data=table2struct(data);

params.expr=char(table(1,j));
params.date=str2num(char(table(2,j)));
params.seq=str2num(char(table(3,j)));
params.ints=str2num(char(table(4,j)));
params.cam1.port=char(table(6,j));
params.cam1.camera=char(table(7,j));
params.cam1.t0=str2num(char(table(8,j)));
params.cam1.mag=str2num(char(table(9,j)));
params.cam1.dt=str2num(char(table(10,j)));
params.cam1.vpulse=str2num(char(table(11,j)));
params.cam1.ang=str2num(char(table(12,j)));
params.cam1.mirror=str2num(char(table(13,j)));
params.cam1.npinholes=str2num(char(table(14,j)));
params.cam1.nrow=str2num(char(table(15,j)));
params.cam1.ncol=str2num(char(table(16,j)));
params.cam1.pinholes=str2num(char(table(17,j)));
params.cam1.filter_mat=char(table(18,j));
params.cam1.filter_thk=str2num(char(table(19,j)));
params.cam2.port=char(table(21,j));
params.cam2.camera=char(table(22,j));
params.cam2.cal_shot=str2num(char(table(23,j)));
params.cam2.strip_dir=char(table(24,j));
params.cam2.t0=str2num(char(table(25,j)));
params.cam2.mag=str2num(char(table(26,j)));
params.cam2.dt=str2num(char(table(27,j)));
params.cam2.vpulse=str2num(char(table(28,j)));
params.cam2.ccd_xwidth=str2num(char(table(29,j)));
params.cam2.ccd_ywidth=str2num(char(table(30,j)));
params.cam2.ang=str2num(char(table(31,j)));
params.cam2.mirror=str2num(char(table(32,j)));
params.cam2.npinholes=str2num(char(table(33,j)));
params.cam2.nrow=str2num(char(table(34,j)));
params.cam2.ncol=str2num(char(table(35,j)));
params.cam2.pinholes=str2num(char(table(36,j)));
params.cam2.filter_mat=char(table(37,j));
params.cam2.filter_thk=str2num(char(table(38,j)));

% hgxd=['expr' "date" "seq" "ints" "hgxd_info1" "port" "camera" "t0" "mag" "dt" "vpulse" "ang" "mirror" "npinholes" "nrow" "ncol" "pinholes" "filter_mat" "filter_thk"];
% 
% gxdNames=["port" "camera" "cal_shot" "strip_dir" "t0" "mag" "dt" "vpulse" "ccd_xwidth" "ccd_ywdith" "ang" "mirror" "npinholes" "nrow" "ncol" "pinholes" "filter_mat"  "filter_thk"];
%
params
end
