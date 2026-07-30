function [Integral]=calculateTheoreticalRatio(Energies,Temps,Trans_Coeffs)

Integral=zeros(size(Temps,2),1);

    for i=1:size(Temps,2)
        B = besselk(0,(Energies./(2*Temps(i)))); %Defining Modified Bessel Function of 2nd Kind of order 0 w/ Argument E/2T
        expo=exp(-Energies./(2*Temps(i))); %Exponential Factor
        W=Trans_Coeffs; %Filter function
        K=DetectorResponse(Energies); %Detector Response
        Integrand=B.*expo.*W.*K; %Product to integrate over
        Integral(i)=trapz(Energies,Integrand); %Integrate the Product
    end


end