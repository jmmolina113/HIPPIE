function [adjusted_lineout1,adjusted_lineout2]=AlignArea_v3(lineout1,lineout2)

normalized_lineout1=(1/max(lineout1(300:600)))*lineout1;
normalized_lineout2=(1/max(lineout2(300:600)))*lineout2;

A=NaN(4000,1);
B=NaN(4000,1);
range=801:1851;
A(range)=normalized_lineout1;
B(range)=normalized_lineout2;

shifts=[-100:1:100];
M=zeros(size(shifts,2),1);

for i=1:size(shifts,2)

    P=abs(A([1000:1600]-shifts(i))-B([1000:1600]));
    [~,index]=min(isnan(P));
    M(i,1)=abs(trapz(P(index:end)));
    
end

[best_shift,~] = find(ismember(M, min(M)));
shift=shifts(best_shift);

adjusted_lineout1=A(range-shift);
adjusted_lineout2=lineout2;



end