function final_lineout_error=lineout_error(Signal_Ratio)

S1=mean(Signal_Ratio(:,1));
SN=mean(Signal_Ratio(:,2));
S2=mean(Signal_Ratio(:,3));

A=abs(S1-SN);
B=abs(S2-SN);

pos_error=mean([A B]);

noise_error=std(Signal_Ratio(:,2));

final_lineout_error=sqrt(pos_error.^2+noise_error.^2);



end