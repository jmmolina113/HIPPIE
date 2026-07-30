function [Fit1,Fit2]=CurveFitting(Z,lineout1,lineout2)

f = fit(Z',lineout1,'exp2');
f2 = fit(Z',lineout2,'exp2');

b=f.b;
d=f.d;

b2=f2.b;
d2=f2.d;

b_avg=mean([b b2]);
d_avg=mean([d d2]);


lower=[-inf,b_avg,-inf,d_avg];
upper=[inf,b_avg,inf,d_avg];

f = fit(Z',lineout1,'exp2','Lower',lower,'Upper',upper);
f2 = fit(Z',lineout2,'exp2','Lower',lower,'Upper',upper);

Fit1=feval(f,Z);
Fit2=feval(f2,Z);


end