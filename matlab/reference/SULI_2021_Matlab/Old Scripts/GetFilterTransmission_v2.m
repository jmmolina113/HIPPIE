function [energy,T]=GetFilterTransmission_v2(file_name1,file_name2,new_thickness,new_thickness2,error,one_or_two)

if one_or_two == 1
    A=strsplit(string(file_name1),'_');
    material=A(1);
    B=strsplit(A(2),'.');
    C=strsplit(B(1),'um');
    standard_thickness=C(1);

    eval(['file="C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Filter Data\' char(material) '_' char(standard_thickness) 'um.txt";']);
    struct=importdata(file,' ');
    data=struct.data;
    energy=data(:,1);
    trans_coeff=data(:,2);

    standard_thickness=str2num(C(1));

    if error==0
    
   T=(trans_coeff).^(((new_thickness)/standard_thickness));

    else
    
       upper_T=(trans_coeff).^(((new_thickness+error)/standard_thickness));
       lower_T=(trans_coeff).^(((new_thickness-error)/standard_thickness));
       new_trans_coeff=(trans_coeff).^(((new_thickness)/standard_thickness));
       
       T=[upper_T new_trans_coeff lower_T];

    
    end


%%%%%%%%%%%%%%%%%%%%%%%%
elseif one_or_two == 2
    A=strsplit(string(file_name1),'_');
    material=A(1);
    B=strsplit(A(2),'.');
    C=strsplit(B(1),'um');
    standard_thickness=C(1);

    eval(['file="C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Filter Data\' char(material) '_' char(standard_thickness) 'um.txt";']);
    struct=importdata(file,' ');
    data=struct.data;
    energy=data(:,1);
    trans_coeff=data(:,2);

    standard_thickness=str2num(C(1));

    if error==0
    
   T=(trans_coeff).^(((new_thickness)/standard_thickness));

    else
    
       upper_T1=(trans_coeff).^(((new_thickness+error)/standard_thickness));
       lower_T1=(trans_coeff).^(((new_thickness-error)/standard_thickness));
       new_trans_coeff1=(trans_coeff).^(((new_thickness)/standard_thickness));
       
    
    end

 
    A=strsplit(string(file_name2),'_');
    material2=A(1);
    B=strsplit(A(2),'.');
    C=strsplit(B(1),'um');
    standard_thickness2=C(1);

    eval(['file="C:\Users\jacob\Documents\Research\SULI 2021\Magnetic Reconnection Project\Filter Data\' char(material2) '_' char(standard_thickness2) 'um.txt";']);
    struct=importdata(file,' ');
    data=struct.data;
    energy=data(:,1);
    trans_coeff2=data(:,2);

    standard_thickness2=str2num(C(1));

    if error==0
    
   T1=(trans_coeff2).^(((new_thickness2)/standard_thickness2));

    else
    
       upper_T2=(trans_coeff2).^(((new_thickness2+error)/standard_thickness2));
       lower_T2=(trans_coeff2).^(((new_thickness2-error)/standard_thickness2));
       new_trans_coeff2=(trans_coeff2).^(((new_thickness2)/standard_thickness2));
       
    
    end
    
    upper_T=upper_T1.*upper_T2;
    lower_T=lower_T1.*lower_T2;
    new_trans_coeff=new_trans_coeff1.*new_trans_coeff2;
    T=[upper_T new_trans_coeff lower_T];

end

end