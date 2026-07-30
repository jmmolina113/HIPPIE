function [adjusted_lineout1,adjusted_lineout2]=AlignArea(lineout1,lineout2)

%Normalizing both lineouts of interest
normalized_lineout1=(1/max(lineout1(300:600)))*lineout1; 
normalized_lineout2=(1/max(lineout2(300:600)))*lineout2;

%Creating three NaN-valued arrays to imbed these lineouts in so we can shift things
%around as we please, and imbedding out lineouts in these arrays.
A=NaN(4000,1);
B=NaN(4000,1);
C=NaN(4000,1);
range=801:1851;

A(range)=normalized_lineout1; 
B(range)=normalized_lineout2;
C(range)=lineout1;
%A and B will be used for calculation, C will be used for the final ouput.
%We need to use the normalized lineouts to calculate the area enclosed by
%them, otherwise we will waste a lot of time calculating area that is
%inherent in the difference of the value of the peaks - i.e., it is faster
%to calculate the shift that minimizes the area enclosed for the normalized
%lineout and then apply the shift to the unnormalized lineout.

shifts=[-100:1:100]; %Pixels by which to shift
M=zeros(size(shifts,2),1); %Matrix to imbed all the answers for each integral in

%The following loop calculates the area enclosed by the two lineouts after
%shifting one by one of the values in the 'shifts' array, and then places
%it in an array of zeros of size(shifts).

for i=1:size(shifts,2)

    P=abs(A([1000:1600]-shifts(i))-B([1000:1600]));
    [~,index]=min(isnan(P));
    M(i,1)=abs(trapz(P(index:end)));
    
end

[best_shift,~] = find(ismember(M, min(M))); %Finding the shift that minimizes the enclosed area



adjusted_lineout1=C((range-shifts(best_shift))); %Applying the shift to the unnormalized lineout for the data output
adjusted_lineout2=lineout2; %Applying the shift to the unnormalized lineout for the data output. 


end