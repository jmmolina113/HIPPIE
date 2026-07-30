function pixels=RealUnits2Pixels(x,params)

%x has units of mm

pixels=((1050)*(4/36)*x*params.mag);


end