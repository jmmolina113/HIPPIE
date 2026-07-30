function [energy,T]=GetFilterTransmission(file_name,new_thickness,error)

A=strsplit(string(file_name),'_');
material=A(1);
B=strsplit(A(2),'.');
C=strsplit(B(1),'um');
standard_thickness=C(1); %The 4 lines above this one are just to be able to read in the material and standard thickness from the file name

eval(['file="C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Filter Data\' char(material) '_' char(standard_thickness) 'um.txt";']);
struct=importdata(file,' '); %Reads in adata
data=struct.data; %Hones in on the data, specifcally
energy=data(:,1);
trans_coeff=data(:,2);

standard_thickness=str2num(C(1));

if error==0
    
   T=(trans_coeff).^(((new_thickness)/standard_thickness)); %Rescales the transmission so that everything works

else
    
       upper_T=(trans_coeff).^(((new_thickness+error)/standard_thickness));
       lower_T=(trans_coeff).^(((new_thickness-error)/standard_thickness));
       new_trans_coeff=(trans_coeff).^(((new_thickness)/standard_thickness));
       
       T=[upper_T new_trans_coeff lower_T];

    
end


end