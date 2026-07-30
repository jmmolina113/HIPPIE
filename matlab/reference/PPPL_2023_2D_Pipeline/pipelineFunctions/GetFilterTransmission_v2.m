function [energy_data,T]=GetFilterTransmission_v2(file_name,new_thickness,error)

split_string=strsplit(string(file_name),'_');
material_name=split_string(1);
split_material=strsplit(split_string(2),'.');
material_thickness=strsplit(split_material(1),'um');
standard_thickness=material_thickness(1); %The 4 lines above this one are just to be able to read in the material and standard thickness from the file name

eval(['file="' char(material_name) '_' char(standard_thickness) 'um.txt";']);
filter_data_structure=importdata(file,' '); %Reads in adata
data=filter_data_structure.data; %Hones in on the data, specifcally
energy_data=data(:,1);
transmission_coeff_data=data(:,2);

standard_thickness=str2num(material_thickness(1));

    if error==0       
        T=(transmission_coeff_data).^(((new_thickness)/standard_thickness)); %Rescales the transmission so that everything works 
    else
        upper_T=(transmission_coeff_data).^(((new_thickness+error)/standard_thickness));
        lower_T=(transmission_coeff_data).^(((new_thickness-error)/standard_thickness));
        new_trans_coeff=(transmission_coeff_data).^(((new_thickness)/standard_thickness));
           
        T=[upper_T new_trans_coeff lower_T];
    end


end